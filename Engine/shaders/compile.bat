@echo off
for /r %%i in (*.frag, *.vert) do C:/VulkanSDK/1.1.126.0/Bin/glslc %%i -o %%~ni.spv