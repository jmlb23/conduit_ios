load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

# Version

swift_library(
    name = "app.library",
    srcs = glob(["**/*.swift"]),
    module_name = "app",
    deps = ["@Alamofire", "@Kingfisher", ]
)

ios_application(
    name = "app",
    app_icons = glob(["Assets.xcassets/AppIcon.appiconset/**"]),
    bundle_id = "com.github.jmlb23.MediumClone",
    bundle_name = "MediumClone",
    executable_name = "MediumCloneBinary",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = [":Info.plist"],
    minimum_os_version = "14.0",
    resources = glob(
        [
            "Assets.xcassets/**",
        ],
        exclude = ["Assets.xcassets/AppIcon.appiconset/**"],
    ),
    visibility = [
        "//:__subpackages__",
        "@rules_xcodeproj//xcodeproj:generated",
    ],
    deps = [
        ":app.library",
    ],
)
