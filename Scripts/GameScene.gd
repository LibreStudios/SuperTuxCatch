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

extends Node3D

var fish_scene: PackedScene = preload("res://Scenes/Fish.tscn")
@export var max_fish_count: int = 5

var collected_fish_count: int = 0

@onready var score_label: Label = $Control/CanvasLayer/Label

func _ready() -> void:
	for i in range(max_fish_count):
		spawn_single_fish()
	update_score_ui()

func _on_timer_timeout() -> void:
	var current_fish = get_tree().get_nodes_in_group("Fish").size()
	if current_fish < max_fish_count:
		spawn_single_fish()

func spawn_single_fish() -> void:
	if fish_scene:
		var fish = fish_scene.instantiate() as Node3D
		var random_x = randf_range(-8.0, 8.0)
		var random_z = randf_range(-8.0, 8.0)
		fish.position = Vector3(random_x, 0.5, random_z)
		add_child(fish)

func add_score() -> void:
	collected_fish_count += 1
	update_score_ui()

func update_score_ui() -> void:
	if score_label:
		score_label.text = "Fish: " + str(collected_fish_count)
