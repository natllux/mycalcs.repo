package main

import "core:fmt"
import "core:strconv"

// The file that manages all operations made with 'mycalc_v1'

// Operators
operatorType :: enum {
	OPERATOR_ADDITION,       // LITTERAL: '+'
	OPERATOR_SUBTRACTION,    // LITTERAL: '-'
	OPERATOR_MULTIPLICATION, // LITTERAL: '*'
	OPERATOR_DIVISION,       // LITTERAL: '/'
	OPERATOR_ERROR,         // Errors Only.
}

// Operations
//
// Accepted operand types (mycalc_v1):
//	. Integers (i.e all of the full numbers): '0', '8', '4524125'...;
//	. Floating Points (i.e all of the decimal numbers): '0.1', '48.3', '7545.01'...
//
// NOTE: Integer values are automatically converted into Floating Points.
//
// -------------------------------------------------------------------------------------
//
// Accepted operator types (mycalc_v1):
//	. Addition Operator (i.e the operator for addition, 'plus'): '+';
//  . Subtraction Operator (i.e the operator for subtraction, 'minus'): '-';
//  . Multiplication Operator (i.e the operator for multiplication, 'multiplied'): '*';
//  . Division Operator (i.e the operator for division, 'divided'): '/';


execute_operation :: proc(op1: string, op2: string, op: operatorType) -> (res: f64, err: [dynamic]string) {
	// Casting the operands into floats for simplicity (for me)
	opr1, ok1 := strconv.parse_f64(op1)
	opr2, ok2 := strconv.parse_f64(op2)

	if !ok1 {
		append(&err, "Error: Invalid Input - Operand 1. The first operand is not a valid input. \nAccepted operand types (mycalc_v1): \n . Integers (i.e all of the full numbers): '0', '8', '4524125'...; \n . Floating Points (i.e all of the decimal numbers): '0.1', '48.3', '7545.01'...\n")
	}
	if !ok2 {
		append(&err, "Error: Invalid Input - Operand 2. The first operand is not a valid input. \nAccepted operand types (mycalc_v1): \n . Integers (i.e all of the full numbers): '0', '8', '4524125'...; \n . Floating Points (i.e all of the decimal numbers): '0.1', '48.3', '7545.01'...\n")
	}

	opt: operatorType = op
	if !ok1 || !ok2 {
		opt = operatorType.OPERATOR_ERROR
	}

    // Executing the correct operation
	switch(opt) {
		case operatorType.OPERATOR_ADDITION:
			res = add_operation(opr1, opr2)
			break

		case operatorType.OPERATOR_SUBTRACTION:
			res = sub_operation(opr1, opr2)
			break

		case operatorType.OPERATOR_MULTIPLICATION:
			res = mul_operation(opr1, opr2)
			break

		case operatorType.OPERATOR_DIVISION:
			if opr2 == 0.0 {
				append(&err, "Error: Unallowed Operation - Division by an unallowed value. Maths do not allow the division of a number by 0.")
			}
			else {
				res = div_operation(opr1, opr2)
			}
			
			break
		case operatorType.OPERATOR_ERROR:
			break
	}

	return res, err
}

// Operations
add_operation :: proc(opr1: f64, opr2: f64) -> f64 {
	return opr1 + opr2
}

sub_operation :: proc(opr1: f64, opr2: f64) -> f64 {
	return opr1 - opr2
}

mul_operation :: proc(opr1: f64, opr2: f64) -> f64 {
	return opr1 * opr2
}

div_operation :: proc(opr1: f64, opr2: f64) -> f64 {
	return opr1 / opr2
}