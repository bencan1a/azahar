# Project Documentation

This directory contains persistent project documentation for Azahar emulator.

## Purpose

The `docs/` directory is for **stable, long-term documentation** that should be version controlled and shared with all contributors.

## What Goes Here

### Architecture Documents
- System design documents
- Module architecture diagrams
- API specifications
- Database schemas (if applicable)

### Technical Specifications
- 3DS hardware implementation notes
- Emulation accuracy documentation
- Performance optimization guides
- Graphics pipeline documentation

### Development Guides
- Code contribution guidelines (extended)
- Testing strategies
- Debugging workflows
- Performance profiling guides

### Research Notes
- 3DS hardware research
- Reverse engineering notes
- Compatibility findings
- Hardware behavior documentation

### Release Documentation
- Changelog details
- Migration guides
- Breaking change documentation
- Version compatibility matrices

## Structure

Organize documentation by topic:

```
docs/
├── architecture/       # System architecture docs
├── emulation/         # Emulation-specific docs
├── graphics/          # GPU and rendering docs
├── audio/             # Audio system docs
├── research/          # Hardware research notes
├── guides/            # Developer guides
└── api/               # API documentation
```

## Documentation Standards

- Use Markdown format (`.md`)
- Include diagrams where helpful (use Mermaid or images)
- Keep docs up-to-date with code changes
- Link to relevant source files
- Date major updates

## Examples

- `architecture/hle-services.md` - HLE service implementation guide
- `graphics/pica200-shader-translation.md` - Shader translation documentation
- `research/3ds-timing-analysis.md` - Hardware timing research
- `guides/debugging-graphics-issues.md` - Graphics debugging workflow

## Notes

- This is separate from `.github/` docs (which are GitHub/Copilot specific)
- For API docs, consider using Doxygen (configured in `Doxyfile`)
- Link to external resources (3dbrew.org, etc.) where appropriate
