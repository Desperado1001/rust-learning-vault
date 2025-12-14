// 这个文件演示如何直接使用 rustc 编译单个文件
// 编译命令: rustc build_example.rs

fn main() {
    println!("这是一个使用 rustc 直接编译的例子！");

    // 演示一些 Rust 特性
    let numbers = vec![1, 2, 3, 4, 5];
    let sum: i32 = numbers.iter().sum();

    println!("数字: {:?}", numbers);
    println!("总和: {}", sum);

    // 使用闭包
    let squared: Vec<i32> = numbers.iter().map(|x| x * x).collect();
    println!("平方: {:?}", squared);
}