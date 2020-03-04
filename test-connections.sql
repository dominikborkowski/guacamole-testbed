

INSERT INTO guacamole_connection ( connection_name, protocol ) VALUES ( 'ubuntu-14.04', 'rdp');
INSERT INTO guacamole_connection ( connection_name, protocol ) VALUES ( 'ubuntu-16.04', 'rdp');
INSERT INTO guacamole_connection ( connection_name, protocol ) VALUES ( 'ubuntu-18.04', 'rdp');

INSERT INTO guacamole_connection_parameter (connection_id, parameter_name, parameter_value) VALUES  ('1', 'hostname', 'ubuntu-14.04');
INSERT INTO guacamole_connection_parameter (connection_id, parameter_name, parameter_value) VALUES  ('1', 'ignore-cert', 'true');
INSERT INTO guacamole_connection_parameter (connection_id, parameter_name, parameter_value) VALUES  ('2', 'hostname', 'ubuntu-16.04');
INSERT INTO guacamole_connection_parameter (connection_id, parameter_name, parameter_value) VALUES  ('2', 'ignore-cert', 'true');
INSERT INTO guacamole_connection_parameter (connection_id, parameter_name, parameter_value) VALUES  ('3', 'hostname', 'ubuntu-18.04');
INSERT INTO guacamole_connection_parameter (connection_id, parameter_name, parameter_value) VALUES  ('3', 'ignore-cert', 'true');

