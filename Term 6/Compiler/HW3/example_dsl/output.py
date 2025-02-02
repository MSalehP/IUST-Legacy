bombs = [[False for y in range(50)] for x in range(6)]
bombs[0][1] = True
bombs[3][5] = True
bombs[4][8] = True
bombs[4][7] = True
def count_neighbors(x, y):
	count = 0
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			if dx == 0 and dy == 0:
				continue
			nx, ny = x + dx, y + dy
			if 0 <= nx < len(bombs) and 0 <= ny < len(bombs[0]) and bombs[nx][ny]:
				count += 1
	return count

for x in range(len(bombs)):
	for y in range(len(bombs[0])):
		if not bombs[x][y]:
			neighbors = count_neighbors(x, y)
			print(neighbors, end='')
		else:
			print('*', end='')
	print()