#!/usr/bin/env python3
"""Consolidate the 691 Bricks Academy preview docs into a handful of
combined Markdown files for upload as NotebookLM sources.

Each combined file keeps a per-doc header (title + source URL) so that
NotebookLM citations stay traceable back to the original academy page.
"""
import csv
import os
import re
from pathlib import Path

SKILL_ROOT = Path(__file__).resolve().parent.parent
MANIFEST = SKILL_ROOT / "index" / "preview_corpus_manifest.csv"
CORPUS = SKILL_ROOT / "corpus" / "bricks-academy-preview"
OUT = SKILL_ROOT / "build" / "notebooklm"

# (filename, human title, predicate on manifest row)
GROUPS = [
    ("01-getting-started.md", "Bricks Academy — Getting Started 入門指南",
     lambda r: r["section"] == "getting-started"),
    ("02-builder-elements.md", "Bricks Academy — Builder 元素 Elements",
     lambda r: r["subsection"] == "builder/elements"),
    ("03-builder-features-styling.md", "Bricks Academy — Builder 功能/樣式/動態內容/介面",
     lambda r: r["section"] == "builder" and r["subsection"] != "builder/elements"),
    ("04-developer-hooks.md", "Bricks Academy — Developer Hooks (Actions & Filters)",
     lambda r: r["subsection"] == "developer/hooks"),
    ("05-developer-schema.md", "Bricks Academy — Developer Schema (Data Model)",
     lambda r: r["subsection"] == "developer/schema"),
    ("06-developer-controls-guides.md", "Bricks Academy — Developer Controls & Guides",
     lambda r: r["section"] == "developer"
               and r["subsection"] not in ("developer/hooks", "developer/schema")),
    ("07-integrations.md", "Bricks Academy — Integrations (WooCommerce/Gutenberg/Maps)",
     lambda r: r["section"] == "integrations"),
]


YT_VIDEO_RE = re.compile(
    r"(?:youtube\.com/watch\?v=|youtu\.be/)([A-Za-z0-9_-]{11})"
)


def extract_youtube(rows):
    """Find unique YouTube *video* URLs across the corpus, mapped to the
    academy pages that embed them. Channel/playlist links are ignored —
    NotebookLM only accepts individual video URLs."""
    videos = {}  # video_id -> set of source page titles
    for r in rows:
        text = (SKILL_ROOT / r["local_path"]).read_text(encoding="utf-8")
        for vid in YT_VIDEO_RE.findall(text):
            videos.setdefault(vid, set()).add(r["title"])
    return videos


def write_youtube_list(rows):
    videos = extract_youtube(rows)
    out_path = OUT / "youtube-sources.txt"
    csv_path = OUT / "youtube-sources.csv"
    with open(out_path, "w", encoding="utf-8") as f:
        for vid in sorted(videos):
            f.write(f"https://www.youtube.com/watch?v={vid}\n")
    with open(csv_path, "w", encoding="utf-8", newline="") as f:
        w = csv.writer(f)
        w.writerow(["video_url", "embedded_in_pages"])
        for vid in sorted(videos):
            w.writerow([f"https://www.youtube.com/watch?v={vid}",
                        " | ".join(sorted(videos[vid]))])
    return len(videos)


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    with open(MANIFEST, encoding="utf-8") as f:
        rows = [r for r in csv.DictReader(f) if r["status"] == "ok"]
    rows.sort(key=lambda r: r["local_path"])

    summary = []
    used = set()
    for fname, title, pred in GROUPS:
        group_rows = [r for r in rows if pred(r) and r["doc_id"] not in used]
        for r in group_rows:
            used.add(r["doc_id"])
        out_path = OUT / fname
        words = 0
        with open(out_path, "w", encoding="utf-8") as out:
            out.write(f"# {title}\n\n")
            out.write(f"> 來源：Bricks Builder Academy 官方文件 | 共 {len(group_rows)} 篇\n\n---\n\n")
            for r in group_rows:
                doc = (SKILL_ROOT / r["local_path"]).read_text(encoding="utf-8")
                words += len(doc.split())
                out.write(f"\n\n## {r['title']}\n\n")
                out.write(f"*來源網址：{r['source_url']}*\n\n")
                out.write(doc.strip())
                out.write("\n\n---\n")
        summary.append((fname, len(group_rows), words, out_path.stat().st_size))

    print(f"{'檔案':<36}{'篇數':>6}{'字數':>10}{'大小KB':>10}")
    print("-" * 62)
    tot_d = tot_w = tot_s = 0
    for fname, n, w, sz in summary:
        print(f"{fname:<36}{n:>6}{w:>10}{sz/1024:>9.0f}")
        tot_d += n; tot_w += w; tot_s += sz
    print("-" * 62)
    print(f"{'合計':<36}{tot_d:>6}{tot_w:>10}{tot_s/1024:>9.0f}")
    n_yt = write_youtube_list(rows)
    print(f"\nYouTube 影片來源：{n_yt} 支 → youtube-sources.txt / .csv")
    print(f"\n輸出目錄：{OUT}")
    leftover = [r["doc_id"] for r in rows if r["doc_id"] not in used]
    if leftover:
        print(f"\n⚠ 未分類 {len(leftover)} 篇：{leftover[:5]}")


if __name__ == "__main__":
    main()
