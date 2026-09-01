package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:unicode"
import "core:time"

// File that runs the cycle of the calculator and determine the operation and operators to use.

clear_blank_str :: proc(input: string) -> string {
    b := strings.builder_make()
    
    for r in input {
        if !unicode.is_space(r) {
            strings.write_rune(&b, r)
        }
    }

    return strings.to_string(b)
}

main :: proc() {
	fmt.print("Hello, welcome to mycalcs.repo/mycalc_v1. This is the first version of mycalcs made by the developper @natllux.")

	for { 
		// Resetting variables
		buf_opr1: [256]byte
		buf_opr2: [256]byte
		buf_opt: [256]byte

		operation_res: f64
		operation_err: [dynamic]string

		// Input Process: First Operand.
		fmt.println("\n\nEnter the first operand:")
		n_opr1, err_opr1 := os.read(os.stdin, buf_opr1[:])
		if err_opr1 != nil {
			fmt.eprintln("Fatal Error: ", err_opr1)
		}
		str_opr1: string = clear_blank_str(string(buf_opr1[:n_opr1]))

		if strings.to_lower(str_opr1) == "exit" {
			break
		}

		time.sleep(500 * time.Millisecond)

		// Input Process: Second Operand.
		fmt.println("Enter the second operand:")
		n_opr2, err_opr2 := os.read(os.stdin, buf_opr2[:])
		if err_opr2 != nil {
			fmt.eprintln("Fatal Error: ", err_opr1)
		}
		str_opr2: string = clear_blank_str(string(buf_opr2[:n_opr2]))

		if strings.to_lower(str_opr2) == "exit" {
			break
		}

		time.sleep(500 * time.Millisecond)

		// Input Process: Operator.
		fmt.println("Enter the operator:")
		n_opt, err_opt := os.read(os.stdin, buf_opt[:])
		if err_opt != nil {
			fmt.eprintln("Fatal Error: ", err_opt)
		}
		str_opt: string = clear_blank_str(string(buf_opt[:n_opt]))

		if strings.to_lower(str_opt) == "exit" {
			break
		}

		time.sleep(500 * time.Millisecond)

		switch(str_opt) {
			case "+":
				operation_res, operation_err = execute_operation(str_opr1, str_opr2, operatorType.OPERATOR_ADDITION)
				break

			case "-":
				operation_res, operation_err = execute_operation(str_opr1, str_opr2, operatorType.OPERATOR_SUBTRACTION)
				break

			case "*":
				operation_res, operation_err = execute_operation(str_opr1, str_opr2, operatorType.OPERATOR_MULTIPLICATION)
				break

			case "/":
				operation_res, operation_err = execute_operation(str_opr1, str_opr2, operatorType.OPERATOR_DIVISION)
				break

			case:
				append(&operation_err, "Error: Invalid Input - Operator. The operator is not a valid input. \n Accepted operator types (mycalc_v1):\n . Addition Operator (i.e the operator for addition, 'plus'): '+';\n . Subtraction Operator (i.e the operator for subtraction, 'minus'): '-';\n . Multiplication Operator (i.e the operator for multiplication, 'multiplied'): '*';\n . Division Operator (i.e the operator for division, 'divided'): '/'; \n")
				reserr, operr := execute_operation(str_opr1, str_opr2, operatorType.OPERATOR_ERROR)
				if len(operr) > 0 {
					i1 := 0
					for i1 < len(operr) {
						curerr := operr[i1]
						append(&operation_err, curerr)
						i1 += 1
					}
				}
				break
		}
		
		// Printing the result
		if len(operation_err) > 0 {
			i := 0
			fmt.print("Error(s) occured doing the execution of the inputed operation, here is/are the error(s): \n\n")
			for i < len(operation_err) {
				cur_err := operation_err[i]
				fmt.printf("%s\n", cur_err)
				i += 1
			}
		}
		else {
			fmt.printf("Result: %f", operation_res)
		}

		time.sleep(1000 * time.Millisecond)
	}

	// Exit Message
	fmt.print("\n\n\nSuccesfully exited 'mycalc_v1' with exit code 0.\n Thanks for using a program made by @natllux! Hope to see you again soon..")
	time.sleep(4000 * time.Millisecond)
	return
}