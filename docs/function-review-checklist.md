# PL/pgSQL Function Review Checklist

A practical checklist for reviewing PostgreSQL PL/pgSQL functions before they become "that one function nobody wants to touch".

## Function design

- Is the function name clear and specific?
- Are input parameters named consistently?
- Is the return type explicit and easy to understand?
- Is the function doing one clear thing?
- Is business logic separated from reporting/query logic where possible?
- Is the function still readable without a heroic amount of coffee?

## Safety

- Does the function modify data?
- If yes, is the modification intentional and documented?
- Are transactions handled by the caller or by the function design?
- Could the function update/delete more rows than expected?
- Are NULL values handled intentionally?
- Are default values intentional?

## Performance

- Are queries using appropriate indexes?
- Are large result sets processed carefully?
- Is dynamic SQL really necessary?
- Are loops avoidable with set-based SQL?
- Are temporary tables or CTEs used intentionally?
- Was the function tested with realistic data volume?

## Error handling

- Are expected exceptions handled?
- Are unexpected exceptions allowed to fail loudly?
- Are exception messages useful?
- Is logging needed?
- Are swallowed errors avoided?

## Maintainability

- Is the function formatted consistently?
- Are complex parts commented?
- Are magic values avoided?
- Is dynamic SQL readable and safe?
- Are permissions and ownership clear?

## Final question

Would you understand this function in six months?

If not, future-you has already opened a ticket.