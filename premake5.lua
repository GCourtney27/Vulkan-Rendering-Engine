-- Helpful premake documentation
-- Tokens https://github.com/premake/premake-core/wiki/Tokens

workspace ("VulkanRenderer")
	architecture ("x86_64")

	configurations
	{
		"Debug",
		"Release"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

dependencies = {}
dependencies["Vulkan"] = "C:/VulkanSDK/*"
dependencies["GLFW"] = "%{prj.name}/Vendor/glfw-3.3.bin.WIN64"
dependencies["glm"] = "%{prj.name}/Vendor/glm"
dependencies["stb"] = "%{prj.name}/Vendor/stb"
dependencies["tinyobjloader"] = "%{prj.name}/Vendor/tinyobjloader-master"


project("Engine")
	location("Engine")
	kind ("ConsoleApp")
	language("C++")
	cppdialect("C++17")
	targetname("VulkanEngine")

	targetdir ("Bin/" .. outputdir .. "/%{prj.name}")
	objdir ("Bin-Int/" .. outputdir .. "/%{prj.name}")

	pchheader("pch.h")
	pchsource("%{prj.name}/Source/pch.cpp")

	files
	{
		"%{prj.name}/Source/**.h",
		"%{prj.name}/Source/**.cpp",
	}

	includedirs
	{
		"%{dependencies.Vulkan}/Include/",
		"%{dependencies.GLFW}/include/",
		"%{dependencies.glm}/",
		"%{dependencies.stb}/",
		"%{dependencies.tinyobjloader}/",

		"%{prj.name}/Source/"
	}

	links
	{
		--"shaderc_combined.lib",
		--"VkLayer_utils.lib",
		"vulkan-1.lib",
		"glfw3.lib",
	}

	libdirs
	{
		"%{dependencies.Vulkan}/Lib/",
		"%{dependencies.GLFW}/lib-vc2019/",
	}

	filter {"system:windows"}
		systemversion "latest"
		flags
		{
			"MultiProcessorCompile"
		}
	
	filter "configurations:Debug"
		defines "_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "NDEBUG"
		runtime "Release"
		optimize "on"
		symbols "on"
