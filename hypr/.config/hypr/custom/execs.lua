hl.on("hyprland.start", function()
	-- hl.exec_cmd("mpvpaper -p -o 'no-audio loop' '*' Pictures/wallpapers/wall.mp4")

	hl.exec_cmd("Telegram -startintray")
	hl.exec_cmd("discord --start-minimized")
	hl.exec_cmd("tailscale-systray")
	hl.exec_cmd("tomate-gtk")
	hl.exec_cmd("arch-update --tray")

	hl.exec_cmd("[workspace 6 silent] betterbird")
	hl.exec_cmd("[workspace 7 silent] kitty btop")
end)
