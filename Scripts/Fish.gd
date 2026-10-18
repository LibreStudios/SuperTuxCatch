# Copyright (C) 2026 LibreStudios

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# at any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends Area3D

func _ready() -> void:
	add_to_group("Fish")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") or body.name == "CharacterBody3D":
		var main_scene = get_tree().current_scene
		if main_scene and main_scene.has_method("add_score"):
			main_scene.add_score()
		
		queue_free()
