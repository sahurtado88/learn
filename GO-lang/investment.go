package main

import "fmt"

func main() {
	var investmentAmount = 1000
	var interestRate = 5.5
	var years = 3

	var futureValue = float64(investmentAmount) * (1 + interestRate/100) * float64(years)
	fmt.Println(futureValue)
}