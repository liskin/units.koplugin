set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set script-interpreter := ["bash", "-eux", "-o", "pipefail"]

# ----------------------------------------------------------------------

help:
    @just --list --unsorted

# ----------------------------------------------------------------------

[script]
update-xray:
	git -C ../xray.koplugin pull
	new_ref=$(git -C ../xray.koplugin rev-list -1 origin/HEAD -- xray.koplugin/xray_units.lua)
	old_ref=$(grep -P -o '^-- source:.*/blob/\K[^/]*' units.koplugin/xray_units.lua)
	git merge-file -L units -L xray_old -L xray_new \
		units.koplugin/xray_units.lua \
		<(git -C ../xray.koplugin show "$old_ref":xray.koplugin/xray_units.lua) \
		<(git -C ../xray.koplugin show "$new_ref":xray.koplugin/xray_units.lua)
	sed -i -e "s|/blob/$old_ref/|/blob/$new_ref/|" units.koplugin/xray_units.lua
