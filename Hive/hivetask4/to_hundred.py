import sys

for num in sys.stdin:
	try:
		num = num.strip()
		num = int(num)
	except ValueError as error:
		continue
	
	if num != None:
		print(str(100 - num))
	else:
		print("")
