/** @file
 * Exercise compiler and linker controls in the WSP CMake self-test.
 */

/** Exercise stack-backed storage so protection remains applicable.
 * @param value Value used to select and populate a stack array element.
 * @return The first array element after the controlled write.
 */
static int exercise_stack_protection(int value)
{
    volatile char values[32] = {0};

    values[value & 31] = (char)value;
    return values[0];
}

/** Run the build-hardening fixture.
 * @param argc Process argument count used as deterministic fixture input.
 * @param argv Process argument vector, which is intentionally not inspected.
 * @return The result of the stack-protection exercise.
 */
int main(int argc, char **argv)
{
    (void)argv;
    return exercise_stack_protection(argc);
}
