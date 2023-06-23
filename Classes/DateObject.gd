extends Node

class_name DateObject

var day : int
var month : int
var year : int

func _init(day : int, month : int, year : int):
	self.day = day
	self.month = month
	self.year = year

func setDay(value : int) -> void:
	if value >= 1 and value <= 31:
		day = value

func getDay() -> int:
	return day

func advanceDay(amount):
	day += amount
	while day > daysInMonth(month, year):
		day -= daysInMonth(month, year)
		month += 1
		if month > 12:
			month = 1
			year += 1

func setMonth(value : int) -> void:
	if value >= 1 and value <= 12:
		month = value

func getMonth() -> int:
	return month

func daysInMonth(month, year) -> int: 
	if month in [4, 6, 9, 11]:
		return 30
	elif month == 2:
		if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
			return 29
		else:
			return 28
	else:
		return 31

func setYear(value : int) -> void:
	if value > 0:
		year = value

func getYear() -> int:
	return year

# func getFullDate() -> int:
#TODO: someway of returning the full date that is not a string
	

func printDate():
	print("Date: %s/%s/%s" % [day, month, year])
