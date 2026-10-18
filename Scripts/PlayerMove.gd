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

extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var sensitivity := 0.005
var animation_state = ""

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Tux/AnimationPlayer.play("Jump")

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = ($CameraPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		# Tux'un döneceği hedef açı (Kameranın açısıyla birleşti):
		var target_rotation = atan2(direction.x, direction.z) + (PI / 2)
		$Tux.rotation.y = lerp_angle($Tux.rotation.y, target_rotation, 0.15)
		if animation_state != "Run":
			animation_state = "Run"
			$Tux/AnimationTree.get("parameters/playback").travel("Run")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if animation_state != "Idle":
			animation_state = "Idle"
			$Tux/AnimationTree.get("parameters/playback").travel("Idle")
	move_and_slide()
func _unhandled_input(event):
	if event is InputEventScreenDrag:
		$CameraPivot.rotate_y(-event.relative.x * sensitivity)
		$CameraPivot/SpringArm3D/Camera3D.rotate_x(-event.relative.y * sensitivity)
		$CameraPivot/SpringArm3D/Camera3D.rotation.x = clamp($CameraPivot/SpringArm3D/Camera3D.rotation.x, deg_to_rad(-60), deg_to_rad(60))
