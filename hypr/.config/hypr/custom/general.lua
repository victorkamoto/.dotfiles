hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "unset"
})
hl.gesture({
    fingers = 4,
    direction = "up",
    action = "unset"
})
hl.gesture({
    fingers = 4,
    direction = "down",
    action = "unset"
})
hl.gesture({
    fingers = 3,
    direction = "swipe",
    action = "unset"
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
    end
})
hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
    end
})
hl.gesture({
    fingers = 4,
    direction = "swipe",
    action = "move"
})
