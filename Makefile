stow_dirs = $(wildcard */)

# restow unstows and then stows again to remove stale symlinks
.PHONY: restow
restow:
	stow --target $(HOME) --verbose --restow $(stow_dirs)

# show what would happen without making the symlinks
.PHONY: dry-run
dry-run:
	stow --no --target $(HOME) --verbose $(stow_dirs)
.PHONY: delete
delete:
	stow --target $(HOME) --verbose --delete $(stow_dirs)
