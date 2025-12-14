// Test file to verify snake_case warnings are disabled
// This file intentionally uses some "non-standard" naming to test the configuration

// These would normally generate snake_case warnings but should now be suppressed
let myVariable = 42;        // non-snake-case (should be my_variable)
let anotherTest = "hello";  // non-snake-case (should be another_test)

fn myFunction() {           // non-snake-case (should be my_function)
    println!("Test function");
}

const MY_CONSTANT: i32 = 100;  // This is correct SCREAMING_SNAKE_CASE

struct MyStruct {           // This is correct PascalCase
    field_one: String,
    fieldTwo: i32,          // This might generate a warning for mixed style
}

impl MyStruct {
    fn new() -> Self {
        MyStruct {
            field_one: String::from("test"),
            fieldTwo: 42,
        }
    }

    fn get_field_one(&self) -> &String {
        &self.field_one
    }
}

fn main() {
    let instance = MyStruct::new();
    println!("Field one: {}", instance.get_field_one());

    myFunction();
    println!("Variables: {}, {}", myVariable, anotherTest);
}