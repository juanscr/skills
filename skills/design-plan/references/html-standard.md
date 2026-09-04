# HTML Standard

Use HTML only when diagrams, substantial navigation, or an explicitly requested
presentation justify it. Otherwise use Markdown.

Each HTML spec is one self-contained file that works without a build step,
network connection, external stylesheet, font, image, script, or runtime
dependency.

## Required experience

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

When an inline SVG materially clarifies the design, the main agent may launch
one `general-purpose` agent using `claude-sonnet-5` at medium effort solely to
create the SVG fragment. Supply the finalized diagram content, labels,
relationships, placement constraints, and accessibility requirements. The
sub-agent returns only the self-contained SVG markup; the main agent integrates
it into the document and remains responsible for its factual accuracy.

## Quality gate

Before presenting a file:

1. Confirm every link and anchor resolves.
2. Confirm every cited path exists and every line range is accurate when one is
   included.
3. Confirm every code block is labelled current with a citation or proposed.
4. Remove placeholders, invented source, stale claims, and presentation that
   does not help the reader make or understand a decision.

The Agent's log is an operational record. Keep it well-formed, readable, and
accurate, but do not apply teaching-document presentation work to it.
