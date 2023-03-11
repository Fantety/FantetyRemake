extends Node

enum LabStatus{
	NORMAL = 0,
	SERIOUS = 1,
}
var lab_status = LabStatus.NORMAL
var elevator_plot_status = false

enum Status{
	NORMAL = 0,
	APRANCE_BROKEN,
	INSIDE_BROKEN,
}
var common_status = {
	"bedroom_terminal" : Status.NORMAL
}
