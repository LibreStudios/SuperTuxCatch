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

extends Control
func _ready() -> void:
	preload("res://Scenes/MainMenu.tscn")
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
