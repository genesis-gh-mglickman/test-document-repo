#!/usr/bin/env bash
set -euo pipefail

REPO="genesis-gh-mglickman/test-document-repo"
BRANCH="add-indexing-summary"
BASE="main"
TITLE="Add indexing summary"
BODY="This PR adds INDEXING_SUMMARY.txt documenting the indexing process and outcomes."

# Uses gh CLI if available and GH_TOKEN configured; otherwise curl
if command -v gh >/dev/null 2>&1; then
  gh pr create --repo "$REPO" --base "$BASE" --head "$BRANCH" --title "$TITLE" --body "$BODY"
else
  curl -sS -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${GH_TOKEN:-}" \
    https://api.github.com/repos/$REPO/pulls \
    -d "{\"title\":\"$TITLE\",\"head\":\"$BRANCH\",\"base\":\"$BASE\",\"body\":\"$BODY\"}"
fi
