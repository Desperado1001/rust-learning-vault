
fn main() {
    println!("Hello, Rust!");

    // 计算斐波那契数列
    let n = 20;
    println!("斐波那契数列第 {} 项是: {}", n, fibonacci(n));
}

fn fibonacci(n: u64) -> u64 {
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
        
    }
}