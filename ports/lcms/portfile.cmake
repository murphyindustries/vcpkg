if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(SHARED_LIBRARY_PATCH "fix-shared-library.patch")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    # Fork of lcms 2.19.1 carrying the MSVC C5033 'register' fix (upstream PR mm2/Little-CMS#576).
    # Revert to REPO mm2/Little-CMS / REF "lcms${VERSION}" once that fix ships in an upstream release.
    REPO MajorMurphy/Little-CMS
    REF 8610fe046bebb487c702990c5f95237096ff002c
    SHA512 fab894f00f1169005d54c179130102f56736a3da666c423c98f4c3a2a66f941701d93089e5af1d130bd25015a53fdb716bbb5ea0f25443e3c4380ebe089e4c5f
    HEAD_REF master
    PATCHES
        ${SHARED_LIBRARY_PATCH}
)

if("fastfloat" IN_LIST FEATURES)
    list(APPEND OPTIONS -Dfastfloat=true)
else()
    list(APPEND OPTIONS -Dfastfloat=false)
endif()
if("threaded" IN_LIST FEATURES)
    list(APPEND OPTIONS -Dthreaded=true)
else()
    list(APPEND OPTIONS -Dthreaded=false)
endif()
if("tools" IN_LIST FEATURES)
    list(APPEND OPTIONS -Dutils=true)
else()
    list(APPEND OPTIONS -Dutils=false)
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${OPTIONS}
)
vcpkg_install_meson()
vcpkg_fixup_pkgconfig()

if("tools" IN_LIST FEATURES)
    vcpkg_copy_tools(
        TOOL_NAMES jpgicc linkicc psicc tificc transicc tifdiff
        AUTO_CLEAN
    )
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/man")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/lcms-config.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/lcms2-config.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/lcms2")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
