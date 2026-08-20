# HTML Standard

Each spec is one self-contained HTML file that works without a build step,
network connection, external stylesheet, font, image, script, or runtime
dependency.

## Required experience

- Use semantic HTML with a clear heading hierarchy and landmarks.
- Provide a linked table of contents and stable section anchors.
- Use responsive CSS that remains readable on narrow and wide screens.
- Provide print styles that preserve headings, code, tables, and diagrams.
- Use high-contrast colors, visible focus states, and more than color alone to
  communicate meaning.
- Distinguish current evidence, proposed design, decisions, alternatives,
  assumptions, open questions, warnings, and approvals visually and in text.
- Wrap long code safely and make wide tables horizontally scrollable.
- Add source paths and line ranges beside every current-code excerpt.
- Use relative links among files in the feature folder.

## Diagrams

Use accessible inline SVG. Do not use Mermaid.

Every diagram must:

- use real current or proposed type and method names;
- include a short title and accessible text;
- remain legible when printed and on a narrow viewport;
- use markers or labels that do not depend only on color; and
- have a nearby plain-English walkthrough so the diagram is never the only
  explanation.

Use an interaction diagram when two or more components exchange control or
data. Use a component or relationship diagram when relationships among three
or more structures matter. Use a state or data-model diagram when lifecycle or
transitions are easier to understand visually. Do not add decorative diagrams.

## Quality gate

Before presenting a file:

1. Confirm it is valid standalone HTML with inline CSS and no external assets.
2. Open it and check internal navigation, relative links, code blocks, tables,
   and SVG labels.
3. Inspect it at desktop and mobile widths.
4. Check print preview or print styling.
5. Confirm evidence, decisions, proposals, and unresolved questions cannot be
   confused with one another.
6. Confirm the document contains no placeholder sections, invented source, or
   stale claims presented as live truth.

