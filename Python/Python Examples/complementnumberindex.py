def two_sum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        complement= target - num
        if complement in seen:
            return [seen[complement],i]
        seen [num] = i
    raise ValueError("No Two numbers add up to the target")    

nums= [2,55,11,15,7]
target=9
result= two_sum(nums, target)
print(f"Indices of numbers that add up to {target}: {result}")