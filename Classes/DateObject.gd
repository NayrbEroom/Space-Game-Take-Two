extends Node

class_name DateObject

var day : int
var month : int
var year : int
var seconds : int

@warning_ignore("shadowed_variable")
func _init(day : int, month : int, year : int, seconds : int):
	self.day = day
	self.month = month
	self.year = year
	self.seconds = seconds

#-------------------------------------------------------------
#setget functions

func setDay(value : int) -> void:
	if value >= 1 and value <= 31:
		day = value

func getDay() -> int:
	return day

func setMonth(value : int) -> void:
	if value >= 1 and value <= 12:
		month = value

func getMonth() -> int:
	return month

func setYear(value : int) -> void:
	if value > 0:
		year = value

func getYear() -> int:
	return year

#-------------------------------------------------------------
#non setget functions

func advanceSeconds(amount: int) -> void:    
	var secondsInDay = 86400
	
	var totalSeconds = self.seconds + amount
	@warning_ignore("integer_division")
	var totalDays = totalSeconds / secondsInDay
	self.seconds = totalSeconds % secondsInDay
	
	# Update the date
	while totalDays > 0:
		var daysInCurrentMonth = self.daysInMonth(month, year)
		if self.day + totalDays <= daysInCurrentMonth:
			self.day += totalDays
			totalDays = 0
		else:
			totalDays -= (daysInCurrentMonth - self.day + 1)
			self.day = 1
			self.month += 1
			if self.month > 12:
				self.month = 1
				self.year += 1

@warning_ignore("shadowed_variable")
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

func printDate():
	print("Date: %s/%s/%s/%s" % [day, month, year, seconds])
