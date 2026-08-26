# HTML Standard

Each spec is one self-contained HTML file that works without a build step,
network connection, external stylesheet, font, image, script, or runtime
dependency.

## Required experience

- Use semantic HTML with a clear heading hierarchy and landmarks.
- Provide a linked table of contents and stable section anchors.
- Use responsive CSS that remains readable on narrow and wide screens.
- Provide print styles that preserve headings, code, tables, and diagrams.
- Keep the document accessible and do not rely on color alone for meaning.
- Make current evidence, proposed design, decisions, and open questions easy to
  distinguish.
- Label current-code excerpts with their source paths and line ranges.
- Use relative links among files in the feature folder.

## Teaching with HTML

Use HTML's available forms—prose, interface sketches, focused code, tables, and
accessible inline SVG diagrams—to make the design easier to learn. Choose a
visual for the idea it clarifies, give it a plain-English explanation, and keep
it focused. Use real names when representing repository code and clearly label
proposed names. Do not use Mermaid or external assets.

## Quality gate

Before presenting a file:

1. Open the standalone file and check navigation, links, code, tables, and
   diagrams at desktop and mobile widths.
2. Check that it remains useful when printed.
3. Confirm the explanation assumes no prior knowledge and clearly separates
   evidence, decisions, proposals, and unresolved questions.
4. Remove placeholders, invented source, and stale claims presented as live
   truth.
