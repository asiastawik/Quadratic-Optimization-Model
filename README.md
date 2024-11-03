# Quadratic Optimization Model Using Gurobi Solver

## Project Overview

This project focuses on formulating and solving a quadratic optimization problem using the Gurobi solver in MATLAB. The aim is to maximize a quadratic objective function subject to specific constraints, leveraging Gurobi's capabilities for efficient optimization of nonlinear problems.

## Problem Description

### Objective Function

The optimization problem is defined as:

**Maximize**:  
\[ f = x^2 + xy + y^2 + yz + 2x \]

### Constraints

The model includes the following constraints:

1. **Linear Equality Constraint**
2. **Quadratic Inequality Constraints**
3. **Non-negativity Constraints**:

### Variable Definitions

- \( x, y, z \): Decision variables representing the quantities to be optimized.

## Gurobi Model Formulation

### Quadratic Objective

The quadratic objective function can be represented in matrix form, where:

- The **Q** matrix is constructed to define the quadratic terms of the objective function.
- The linear coefficients for the objective function are specified accordingly.

### Quadratic Constraints

The quadratic constraints are formulated using Gurobi's `quadcon` structure, which allows for specifying quadratic expressions. Each quadratic constraint can be defined with:

- **Qc**: A square matrix representing the coefficients of the quadratic terms.
- **q**: A vector for the linear terms.
- **rhs**: The right-hand side value for each constraint.
- **sense**: Defines the type of constraint (e.g., '<', '=', '>').

### Implementation in MATLAB

The model is implemented in MATLAB using the Gurobi solver. The following steps outline the implementation process:

1. **Define the Decision Variables**: Create variables for \( x, y, z \) with appropriate bounds.
2. **Set Up the Objective Function**: Use the Q matrix and linear coefficients to construct the objective function.
3. **Add Constraints**: Incorporate linear and quadratic constraints into the model using Gurobi's API.
4. **Optimize the Model**: Solve the optimization problem using Gurobi and retrieve the results.

## Expected Outcomes

The project will yield the optimal values of the decision variables \( x, y, z \) that maximize the objective function while satisfying all constraints. The solution will include:

- Optimal values for \( x, y, z \).
- The maximum value of the objective function.

## Future Enhancements

- **Sensitivity Analysis**: Implement sensitivity analysis to understand the effect of changing coefficients in the objective function and constraints.
- **Scenario Analysis**: Extend the model to evaluate different scenarios with varying constraints or objective functions.
- **Visualization**: Develop visualization tools to better interpret the optimization results and constraints.

## Conclusion

This project showcases the application of Gurobi solver in MATLAB for solving a quadratic optimization problem. By leveraging Gurobi's robust optimization capabilities, the project effectively demonstrates how to maximize a quadratic objective function subject to complex constraints, providing valuable insights into optimization techniques in mathematical programming.
