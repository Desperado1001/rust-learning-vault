- **.vscode/settings.json**
```json
{
    "configurations": [
        {
            "name": "ARM Kernel Development",
            "includePath": [
                "${workspaceFolder}/**",
                "/home/paolo/linux-master/include",
                "/home/paolo/linux-master/arch/arm/include",
                "/home/paolo/linux-master/arch/arm/include/generated",
                "/home/paolo/linux-master/include/uapi",
                "/home/paolo/linux-master/arch/arm/include/uapi",
                "/home/paolo/linux-master/include/generated/uapi",
                "/home/paolo/linux-master/scripts/mod"
            ],
            "defines": [
                "MODULE",
                "__KERNEL__",
                "LINUX",
                "__ARM_ARCH_7A__",
                "CONFIG_ARM",
                "KBUILD_MODNAME=\"simple_char_driver\"",
                "KBUILD_BASENAME=\"simple_char_driver\""
            ],
            "compilerPath": "/usr/bin/arm-linux-gnueabihf-gcc",
            "cStandard": "c11",
            "intelliSenseMode": "linux-gcc-arm",
            "compilerArgs": [
                "-nostdinc",
                "-isystem",
                "/usr/lib/gcc-cross/arm-linux-gnueabihf/*/include",
                "-D__KERNEL__",
                "-DMODULE"
            ]
        }
    ],
    "version": 4
}
```


- **.vscode/c_cpp_properties.json**
```json
{
    "configurations": [
        {
            "name": "ARM Kernel Development",
            "includePath": [
                "${workspaceFolder}/**",
                "/home/paolo/linux-master/include",
                "/home/paolo/linux-master/arch/arm/include",
                "/home/paolo/linux-master/arch/arm/include/generated",
                "/home/paolo/linux-master/include/uapi",
                "/home/paolo/linux-master/arch/arm/include/uapi",
                "/home/paolo/linux-master/include/generated/uapi",
                "/home/paolo/linux-master/scripts/mod"
            ],
            "defines": [
                "MODULE",
                "__KERNEL__",
                "LINUX",
                "__ARM_ARCH_7A__",
                "CONFIG_ARM",
                "KBUILD_MODNAME=\"simple_char_driver\"",
                "KBUILD_BASENAME=\"simple_char_driver\""
            ],
            "compilerPath": "/usr/bin/arm-linux-gnueabihf-gcc",
            "cStandard": "c11",
            "intelliSenseMode": "linux-gcc-arm",
            "compilerArgs": [
                "-nostdinc",
                "-isystem",
                "/usr/lib/gcc-cross/arm-linux-gnueabihf/*/include",
                "-D__KERNEL__",
                "-DMODULE"
            ]
        }
    ],
    "version": 4
}
```