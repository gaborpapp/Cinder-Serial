if( NOT TARGET Cinder-Serial )
	get_filename_component( CINDER_SERIAL_ROOT_PATH "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE )

	list( APPEND CINDER_SERIAL_SOURCES
		${CINDER_SERIAL_ROOT_PATH}/src/SerialDevice.cpp
		${CINDER_SERIAL_ROOT_PATH}/lib/serial/src/serial.cc
	)

	if ( UNIX )
		list( APPEND CINDER_SERIAL_SOURCES
			${CINDER_SERIAL_ROOT_PATH}/lib/serial/src/impl/unix.cc
			${CINDER_SERIAL_ROOT_PATH}/lib/serial/src/impl/list_ports/list_ports_linux.cc
		)
	endif()

	add_library( Cinder-Serial ${CINDER_SERIAL_SOURCES} )

	list( APPEND CINDER_SERIAL_INCLUDE_DIRS
		${CINDER_SERIAL_ROOT_PATH}/include
		${CINDER_SERIAL_ROOT_PATH}/lib/serial/include
		${CINDER_SERIAL_ROOT_PATH}/lib/serial/include/serial
		)

	target_include_directories( Cinder-Serial PUBLIC "${CINDER_SERIAL_INCLUDE_DIRS}" )

	if( NOT TARGET cinder )
		include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		find_package( cinder REQUIRED PATHS
			"${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
			"$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()

	target_link_libraries( Cinder-Serial PRIVATE cinder )
endif()
