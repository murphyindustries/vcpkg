vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/libultrahdr
    REF 82b4f6da9f4db25f51a3a40201ab6eb86b6d6bb7
    SHA512 52bc848c3c936548ff457e31bf7c8ae7fcf88edb32ea06650fce1b4374c03f3bdf0eef013e985dde8cb4832a7db86d39fcd7ee025605fdd4619cbd5f7b76c51e
    HEAD_REF master
)
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_build()

# libultrahdr has no install target; copy build outputs manually
set(BUILDTREES_REL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
set(BUILDTREES_DBG "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")

file(INSTALL "${BUILDTREES_REL}/uhdr.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${BUILDTREES_REL}/uhdr.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/bin")

file(INSTALL "${BUILDTREES_DBG}/uhdr.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
file(INSTALL "${BUILDTREES_DBG}/uhdr.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")

file(INSTALL "${SOURCE_PATH}/ultrahdr_api.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(INSTALL "${SOURCE_PATH}/README.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
