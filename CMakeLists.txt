cmake_minimum_required(VERSION 3.26)

project(HeapsC)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)

# set environment variable to where the hashlink source is
# clone hashlink from github 
set(HL_DIR $ENV{HASLINK_DIR})

list(APPEND CMAKE_MODULE_PATH
    ${HL_DIR}/other/cmake
)

message(STATUS "Hashlink Directory: ${HL_DIR}")
message(STATUS "C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")

# find_package(SDL2) --> not needed because linked with sdl.hdll

add_executable(HeapsC out/c/main.c)

# Set RPATH relative to executable location
# set_target_properties(HeapsC PROPERTIES
#     BUILD_RPATH_USE_ORIGIN TRUE
# )

if(UNIX)
    # so that cmake will not INJECT the absolute RPATH

    set(CMAKE_SKIP_RPATH TRUE) # if not this line, readelf -d will become 0x000000000000001d (RUNPATH)    Library runpath: [/path to hashlink:/path to/hdll_symlinks

    # if not this line the app will look into the default libs folder
    # sets the rpath to $ORIGIN so it will look for the lib*.so in the directory where the app is located
    target_link_options(HeapsC PRIVATE
        "LINKER:--rpath,$ORIGIN"
    )
endif(UNIX)

# because compiling haslink generates hdll
set(SYMLINK_DIR ${CMAKE_BINARY_DIR}/hdll_symlinks)
# we create a temporary directory so the dll will be renamed to lib*.so (convention)
file(MAKE_DIRECTORY ${SYMLINK_DIR})

set(HDLLS sdl.hdll fmt.hdll ui.hdll)

# Loop and create symlinks: libsdl.so → sdl.hdll
foreach(hdll ${HDLLS})
    get_filename_component(name_we ${hdll} NAME_WE)
    set(so_name lib${name_we}.so)
    add_custom_command(
        OUTPUT ${SYMLINK_DIR}/${so_name}
        COMMAND ${CMAKE_COMMAND} -E create_symlink
            ${HL_DIR}/${hdll}
            ${SYMLINK_DIR}/${so_name}
        DEPENDS ${HL_DIR}/${hdll}
    )
    list(APPEND HDLL_SYMLINKS ${SYMLINK_DIR}/${so_name})
    list(APPEND LIB_HDLLS ${so_name})
endforeach()

# Add a dummy custom target to ensure symlinks are created before linking
add_custom_target(GenerateSymlinks ALL DEPENDS ${HDLL_SYMLINKS})

# Make symlink generation happen before linking the executable
add_dependencies(HeapsC GenerateSymlinks)

target_include_directories(HeapsC PUBLIC 
    out/c
    # ${SDL2_INCLUDE_DIR}
)

target_link_directories(HeapsC PRIVATE 
    ${HL_DIR} # for libhl.so
    ${SYMLINK_DIR} # for the generated symbolic link to hdlls
)

target_link_libraries(HeapsC
    m
    hl
    ${LIB_HDLLS}
    # we cannot use the following because it will create RPTH to an absolute path
    # ${HL_DIR}/sdl.hdll
    # ${HL_DIR}/fmt.hdll
    # ${HL_DIR}/ui.hdll
    # ${HL_DIR}/heaps.hdll ---> not needed
    # ${SDL2_LIBRARY} ---> not needed
)

# Copy .hdll files next to binary
foreach(hdll ${HDLLS})
    # get name without extension
    get_filename_component(name_we ${hdll} NAME_WE)

    add_custom_command(TARGET HeapsC POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            ${HL_DIR}/${hdll}
            $<TARGET_FILE_DIR:HeapsC>/lib${name_we}.so
    )
endforeach()