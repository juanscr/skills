# HTML Report Format

Render the architectural review as one self-contained HTML file in the OS temp
directory. Use Tailwind and Mermaid from CDNs when network access is available.
Use Mermaid for graph-shaped relationships and hand-built HTML or SVG for
editorial diagrams such as mass diagrams and cross-sections.

## Structure

Use a concise header containing the repository name, date, and a diagram
legend. Follow it with candidate cards and a top-recommendation section.

Each candidate is an `<article>` with:

- a short title naming the deepening;
- a `Strong`, `Worth exploring`, or `Speculative` badge;
- a monospaced file list;
- a side-by-side before/after diagram;
- one-sentence problem and solution statements;
- short locality, leverage, and testing wins; and
- an ADR warning when evidence warrants reopening an ADR.

The report should link each card to its absolute candidate-spec path under the
shared `coding-specs` root.

## Diagram patterns

Choose the diagram that best explains the candidate:

- **Mermaid graph:** dependencies, call flow, or leakage across a seam.
- **Hand-built boxes and arrows:** a deep module with internal implementation
  details faded behind a small interface.
- **Cross-section:** many thin modules before, a deep module after.
- **Mass diagram:** an interface nearly as large as the implementation before,
  and a small interface hiding substantial implementation after.
- **Call-graph collapse:** a caller-visible tree before, internal calls
  absorbed inside a deep module after.

## Style and language

Keep the page visual and editorial rather than dashboard-like. Use generous
whitespace and restrained colour: one accent, red for leakage, and amber for
ADR warnings.

Use the architectural vocabulary precisely: **module**, **interface**,
**implementation**, **depth**, **deep**, **shallow**, **seam**, **adapter**,
**leverage**, and **locality**. Avoid generic claims such as "cleaner code" or
"easier to maintain." State the concrete architectural gain instead.
