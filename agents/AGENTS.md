# Global Agent Instructions

## Fail Fast Principle

**Core Principle**: Implement only what is explicitly requested. When something fails, let it fail with a clear error. Do not add automatic recovery, retry logic, or fallback behaviors unless specifically instructed.

### What TO do:
- Throw or return errors immediately when operations fail
- Provide clear error messages about what went wrong
- Implement exactly the behavior specified, nothing more

### What NOT to do (unless explicitly requested):
- **File Operations**: Don't auto-create missing directories or files
- **Missing Data**: Don't provide default values for required parameters
- **Network/API Calls**: Don't implement automatic retries or alternative endpoints
- **Error Recovery**: Don't silently catch and suppress errors
- **Validation Failures**: Don't skip invalid records or attempt to fix malformed data
- **Resource Loading**: Don't fall back to alternative resources when the specified one fails

The user will explicitly specify when fallback behavior, retries, or error recovery is desired.