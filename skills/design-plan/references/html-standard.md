# HTML Standard

Use the format selected by the artifact requirements. Apply this standard to
human-facing HTML plans only. The JSON Agent's log has no presentation layer.

Each HTML spec is one self-contained file that works without a build step,
network connection, external stylesheet, font, image, script, or runtime
dependency.

## Required experience

- Always use dark mode: declare `color-scheme: dark` and explicitly style dark
  page and surface backgrounds with readable light text. Keep tables, code,
  callouts, links, and SVG diagrams in the same palette. Dark mode must remain
  active regardless of the operating-system theme; no light-mode default or
  automatic light-theme switch.
- Use semantic HTML with a clear heading hierarchy and landmarks.
- Add a linked table of contents and stable anchors when the document is long
  enough to need them.
- Use responsive CSS that remains readable on narrow and wide screens.
- Keep the document accessible and do not rely on color alone for meaning.
- Make evidence, proposals, decisions, superseded material, and open questions
  easy to distinguish.
- Use relative links among files in the feature folder.

## Teaching with HTML

Use prose, focused code, tables, and accessible inline SVG diagrams only where
they clarify a decision. Give every visual a plain-English explanation. Use real
names for repository code and clearly label proposed names. Do not use Mermaid
or external assets.

When an inline SVG materially clarifies the design, the coordinator may invoke
`model-selection` and launch one `general-purpose` visual worker solely to
create the SVG fragment. Supply the finalized diagram content, labels,
relationships, placement constraints, and accessibility requirements. The
worker returns only the self-contained SVG markup; the coordinator integrates
it into the document and remains responsible for its factual accuracy.

## Quality gate

Before presenting a file:

1. Confirm every link and anchor resolves.
2. Confirm every cited path exists and every line range is accurate when one is
   included.
3. Confirm every code block is labelled current with a citation or proposed.
4. Remove placeholders, invented source, stale claims, and presentation that
   does not help the reader make or understand a decision.
5. Confirm dark backgrounds and legible foregrounds throughout, including code,
   tables, and diagrams, even when the operating system uses light mode.
