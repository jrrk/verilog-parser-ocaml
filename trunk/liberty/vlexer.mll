(******************************************************************************
*
*    DESCRIPTION: Verilog ocamlex lexer file
*
******************************************************************************
*
* Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
* redistribute it and/or modify it under the terms of either the GNU
* General Public License or the Perl Artistic License.
*
* This code is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
******************************************************************************
* Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
******************************************************************************)

{
open Liberty_parser
open Lexing
open Setup

let ksymbols = Hashtbl.create 256;;

let enter_keyword id keyword = 
if Hashtbl.mem ksymbols id then
  Printf.printf "Error: repeated keyword %s\n" id
else begin
(*  Printf.printf "Enter %s\n" id; *)
  Hashtbl.add ksymbols id keyword
  end

let hlog lexbuf ktok:token = begin
let item = {tok=ktok;strt=(Lexing.lexeme_start lexbuf);stop=(Lexing.lexeme_end lexbuf);key=true} in
history.(!histcnt) := item;
if (Globals.verbose > 0) then
   Printf.printf "Trace %d : %s (%d-%d)\n"  !histcnt (str_token (item.tok)) item.strt item.stop;
ignore(histcnt := (!histcnt+1)mod hsiz);
ktok
end

let _ = List.iter (fun (str,key) -> enter_keyword str key)
[
("address",	LIBERTY_ATTRENUM_address) ;
("address_width",	LIBERTY_ATTRENUM_address_width) ;
("area_coefficient",	LIBERTY_ATTRENUM_area_coefficient) ;
("area",	LIBERTY_ATTRENUM_area) ;
("auxiliary_pad_cell",	LIBERTY_ATTRENUM_auxiliary_pad_cell) ;
("base_curves_group",	LIBERTY_ATTRENUM_base_curves_group) ;
("base_curves",	LIBERTY_GROUPENUM_base_curves) ;
("base_curve_type",	LIBERTY_ATTRENUM_base_curve_type) ;
("base_type",	LIBERTY_ATTRENUM_base_type) ;
("bit_from",	LIBERTY_ATTRENUM_bit_from) ;
("bit_to",	LIBERTY_ATTRENUM_bit_to) ;
("bit_width",	LIBERTY_ATTRENUM_bit_width) ;
("bundle",	LIBERTY_GROUPENUM_bundle) ;
("bus",	LIBERTY_GROUPENUM_bus) ;
("bus_naming_style",	LIBERTY_ATTRENUM_bus_naming_style) ;
("bus_type",	LIBERTY_ATTRENUM_bus_type) ;
("calc_mode",	LIBERTY_ATTRENUM_calc_mode) ;
("capacitance",	LIBERTY_ENUM_capacitance) ;
("capacitive_load_unit",	LIBERTY_ATTRENUM_capacitive_load_unit) ;
("ccs_lu_table_template",	LIBERTY_GROUPENUM_ccs_lu_table_template) ;
("ccsn_first_stage",	LIBERTY_GROUPENUM_ccsn_first_stage) ;
("ccsn_last_stage",	LIBERTY_GROUPENUM_ccsn_last_stage) ;
("ccs_timing_base_curve",	LIBERTY_GROUPENUM_ccs_timing_base_curve) ;
("ccs_timing_base_curve_template",	LIBERTY_GROUPENUM_ccs_timing_base_curve_template) ;
("cell_degradation",	LIBERTY_GROUPENUM_cell_degradation) ;
("cell_fall",	LIBERTY_GROUPENUM_cell_fall) ;
("cell_fall_to_pct",	LIBERTY_GROUPENUM_cell_fall_to_pct) ;
("cell_footprint",	LIBERTY_ATTRENUM_cell_footprint) ;
("cell_leakage_power",	LIBERTY_ATTRENUM_cell_leakage_power) ;
("cell",	LIBERTY_GROUPENUM_cell) ;
("cell_name",	LIBERTY_ATTRENUM_cell_name) ;
("cell_rise",	LIBERTY_GROUPENUM_cell_rise) ;
("cell_rise_to_pct",	LIBERTY_GROUPENUM_cell_rise_to_pct) ;
("clear",	LIBERTY_ATTRENUM_clear) ;
("clear_preset_var1",	LIBERTY_ATTRENUM_clear_preset_var1) ;
("clear_preset_var2",	LIBERTY_ATTRENUM_clear_preset_var2) ;
("clocked_on_also",	LIBERTY_ATTRENUM_clocked_on_also) ;
("clocked_on",	LIBERTY_ATTRENUM_clocked_on) ;
("clock_gate_clock_pin",	LIBERTY_ATTRENUM_clock_gate_clock_pin) ;
("clock_gate_enable_pin",	LIBERTY_ATTRENUM_clock_gate_enable_pin) ;
("clock_gate_obs_pin",	LIBERTY_ATTRENUM_clock_gate_obs_pin) ;
("clock_gate_out_pin",	LIBERTY_ATTRENUM_clock_gate_out_pin) ;
("clock_gate_test_pin",	LIBERTY_ATTRENUM_clock_gate_test_pin) ;
("clock_gating_flag",	LIBERTY_ATTRENUM_clock_gating_flag) ;
("clock_gating_integrated_cell",	LIBERTY_ATTRENUM_clock_gating_integrated_cell) ;
("clock",	LIBERTY_ATTRENUM_clock) ;
("clock_pin",	LIBERTY_ATTRENUM_clock_pin) ;
("coefs",	LIBERTY_ATTRENUM_coefs) ;
("column_address",	LIBERTY_ATTRENUM_column_address) ;
("comment",	LIBERTY_ATTRENUM_comment) ;
("compact_ccs_fall",	LIBERTY_GROUPENUM_compact_ccs_fall) ;
("compact_ccs_rise",	LIBERTY_GROUPENUM_compact_ccs_rise) ;
("compact_lut_template",	LIBERTY_GROUPENUM_compact_lut_template) ;
("complementary_pin",	LIBERTY_ATTRENUM_complementary_pin) ;
("compressed_ccs_timing_rise",	LIBERTY_GROUPENUM_compressed_ccs_timing_rise) ;
("connection_class",	LIBERTY_ATTRENUM_connection_class) ;
("constraint_high",	LIBERTY_ATTRENUM_constraint_high) ;
("constraint",	LIBERTY_ATTRENUM_constraint) ;
("constraint_low",	LIBERTY_ATTRENUM_constraint_low) ;
("contention_condition",	LIBERTY_ATTRENUM_contention_condition) ;
("current_unit",	LIBERTY_ATTRENUM_current_unit) ;
("curve_id",	LIBERTY_ATTRENUM_curve_id) ;
("curve_x",	LIBERTY_ATTRENUM_curve_x) ;
("curve_y",	LIBERTY_ATTRENUM_curve_y) ;
("data_in",	LIBERTY_ATTRENUM_data_in) ;
("data_type",	LIBERTY_ATTRENUM_data_type) ;
("date",	LIBERTY_ATTRENUM_date) ;
("dc_current",	LIBERTY_GROUPENUM_dc_current) ;
("dcm_timing",	LIBERTY_ATTRENUM_dcm_timing) ;
("default_cell_failure_rate",	LIBERTY_ATTRENUM_default_cell_failure_rate) ;
("default_cell_leakage_power",	LIBERTY_ATTRENUM_default_cell_leakage_power) ;
("default_connection_class",	LIBERTY_ATTRENUM_default_connection_class) ;
("default_edge_rate_breakpoint_f0",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_f0) ;
("default_edge_rate_breakpoint_f1",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_f1) ;
("default_edge_rate_breakpoint_r0",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_r0) ;
("default_edge_rate_breakpoint_r1",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_r1) ;
("default_fall_delay_intercept",	LIBERTY_ATTRENUM_default_fall_delay_intercept) ;
("default_fall_pin_resistance",	LIBERTY_ATTRENUM_default_fall_pin_resistance) ;
("default_fanout_load",	LIBERTY_ATTRENUM_default_fanout_load) ;
("default_hold_coefficient",	LIBERTY_ATTRENUM_default_hold_coefficient) ;
("default_inout_pin_cap",	LIBERTY_ATTRENUM_default_inout_pin_cap) ;
("default_inout_pin_fall_res",	LIBERTY_ATTRENUM_default_inout_pin_fall_res) ;
("default_inout_pin_rise_res",	LIBERTY_ATTRENUM_default_inout_pin_rise_res) ;
("default_input_pin_cap",	LIBERTY_ATTRENUM_default_input_pin_cap) ;
("default_intrinsic_fall",	LIBERTY_ATTRENUM_default_intrinsic_fall) ;
("default_intrinsic_rise",	LIBERTY_ATTRENUM_default_intrinsic_rise) ;
("default_leakage_power_density",	LIBERTY_ATTRENUM_default_leakage_power_density) ;
("default_max_capacitance",	LIBERTY_ATTRENUM_default_max_capacitance) ;
("default_max_fanout",	LIBERTY_ATTRENUM_default_max_fanout) ;
("default_max_transition",	LIBERTY_ATTRENUM_default_max_transition) ;
("default_max_utilization",	LIBERTY_ATTRENUM_default_max_utilization) ;
("default_min_porosity",	LIBERTY_ATTRENUM_default_min_porosity) ;
("default_operating_conditions",	LIBERTY_ATTRENUM_default_operating_conditions) ;
("default_output_pin_cap",	LIBERTY_ATTRENUM_default_output_pin_cap) ;
("default_output_pin_fall_res",	LIBERTY_ATTRENUM_default_output_pin_fall_res) ;
("default_output_pin_rise_res",	LIBERTY_ATTRENUM_default_output_pin_rise_res) ;
("default_power_rail",	LIBERTY_ATTRENUM_default_power_rail) ;
("default_rc_fall_coefficient",	LIBERTY_ATTRENUM_default_rc_fall_coefficient) ;
("default_rc_rise_coefficient",	LIBERTY_ATTRENUM_default_rc_rise_coefficient) ;
("default_reference_capacitance",	LIBERTY_ATTRENUM_default_reference_capacitance) ;
("default_rise_delay_intercept",	LIBERTY_ATTRENUM_default_rise_delay_intercept) ;
("default_rise_pin_resistance",	LIBERTY_ATTRENUM_default_rise_pin_resistance) ;
("default_setup_coefficient",	LIBERTY_ATTRENUM_default_setup_coefficient) ;
("default_slope_fall",	LIBERTY_ATTRENUM_default_slope_fall) ;
("default_slope_rise",	LIBERTY_ATTRENUM_default_slope_rise) ;
("default_threshold_voltage_group",	LIBERTY_ATTRENUM_default_threshold_voltage_group) ;
("default_timing",	LIBERTY_ATTRENUM_default_timing) ;
("default_wire_load_area",	LIBERTY_ATTRENUM_default_wire_load_area) ;
("default_wire_load_capacitance",	LIBERTY_ATTRENUM_default_wire_load_capacitance) ;
("default_wire_load",	LIBERTY_ATTRENUM_default_wire_load) ;
("default_wire_load_mode",	LIBERTY_ATTRENUM_default_wire_load_mode) ;
("default_wire_load_resistance",	LIBERTY_ATTRENUM_default_wire_load_resistance) ;
("default_wire_load_selection",	LIBERTY_ATTRENUM_default_wire_load_selection) ;
("define_cell_area",	LIBERTY_ATTRENUM_define_cell_area) ;
("delay_model",	LIBERTY_ATTRENUM_delay_model) ;
("direction",	LIBERTY_ATTRENUM_direction) ;
("divided_by",	LIBERTY_ATTRENUM_divided_by) ;
("domain",	LIBERTY_GROUPENUM_domain) ;
("dont_fault",	LIBERTY_ATTRENUM_dont_fault) ;
("dont_touch",	LIBERTY_ATTRENUM_dont_touch) ;
("dont_use",	LIBERTY_ATTRENUM_dont_use) ;
("downto",	LIBERTY_ATTRENUM_downto) ;
("drive_current",	LIBERTY_ATTRENUM_drive_current) ;
("driver_type",	LIBERTY_ATTRENUM_driver_type) ;
("driver_waveform_fall",	LIBERTY_ATTRENUM_driver_waveform_fall) ;
("driver_waveform",	LIBERTY_ATTRENUM_driver_waveform) ;
("driver_waveform_name",	LIBERTY_ATTRENUM_driver_waveform_name) ;
("driver_waveform_rise",	LIBERTY_ATTRENUM_driver_waveform_rise) ;
("duty_cycle",	LIBERTY_ATTRENUM_duty_cycle) ;
("dynamic_current",	LIBERTY_GROUPENUM_dynamic_current) ;
("edge_rate_breakpoint_f0",	LIBERTY_ATTRENUM_edge_rate_breakpoint_f0) ;
("edge_rate_breakpoint_f1",	LIBERTY_ATTRENUM_edge_rate_breakpoint_f1) ;
("edge_rate_breakpoint_r0",	LIBERTY_ATTRENUM_edge_rate_breakpoint_r0) ;
("edge_rate_breakpoint_r1",	LIBERTY_ATTRENUM_edge_rate_breakpoint_r1) ;
("edge_rate_fall",	LIBERTY_ATTRENUM_edge_rate_fall) ;
("edge_rate_load_fall",	LIBERTY_ATTRENUM_edge_rate_load_fall) ;
("edge_rate_load_rise",	LIBERTY_ATTRENUM_edge_rate_load_rise) ;
("edge_rate_rise",	LIBERTY_ATTRENUM_edge_rate_rise) ;
("edge_rate_sensitivity_f0",	LIBERTY_ATTRENUM_edge_rate_sensitivity_f0) ;
("edge_rate_sensitivity_f1",	LIBERTY_ATTRENUM_edge_rate_sensitivity_f1) ;
("edge_rate_sensitivity_r0",	LIBERTY_ATTRENUM_edge_rate_sensitivity_r0) ;
("edge_rate_sensitivity_r1",	LIBERTY_ATTRENUM_edge_rate_sensitivity_r1) ;
("edges",	LIBERTY_ATTRENUM_edges) ;
("edge_type",	LIBERTY_ATTRENUM_edge_type) ;
("electromigration",	LIBERTY_GROUPENUM_electromigration) ;
("em_lut_template",	LIBERTY_GROUPENUM_em_lut_template) ;
("em_max_toggle_rate",	LIBERTY_GROUPENUM_em_max_toggle_rate) ;
("em_temp_degradation_factor",	LIBERTY_ATTRENUM_em_temp_degradation_factor) ;
("enable_also",	LIBERTY_ATTRENUM_enable_also) ;
("enable",	LIBERTY_ATTRENUM_enable) ;
("equal_or_opposite_output",	LIBERTY_ATTRENUM_equal_or_opposite_output) ;
("failure_rate",	LIBERTY_ATTRENUM_failure_rate) ;
("fall_capacitance",	LIBERTY_ENUM_fall_capacitance) ;
("fall_capacitance_range",	LIBERTY_ENUM_fall_capacitance_range) ;
("fall_constraint",	LIBERTY_GROUPENUM_fall_constraint) ;
("fall_current_slope_after_threshold",	LIBERTY_ATTRENUM_fall_current_slope_after_threshold) ;
("fall_current_slope_before_threshold",	LIBERTY_ATTRENUM_fall_current_slope_before_threshold) ;
("fall_delay_intercept",	LIBERTY_ATTRENUM_fall_delay_intercept) ;
("falling_together_group",	LIBERTY_ATTRENUM_falling_together_group) ;
("fall_net_delay",	LIBERTY_GROUPENUM_fall_net_delay) ;
("fall_pin_resistance",	LIBERTY_ATTRENUM_fall_pin_resistance) ;
("fall_power",	LIBERTY_GROUPENUM_fall_power) ;
("fall_propagation",	LIBERTY_GROUPENUM_fall_propagation) ;
("fall_resistance",	LIBERTY_ATTRENUM_fall_resistance) ;
("fall_time_after_threshold",	LIBERTY_ATTRENUM_fall_time_after_threshold) ;
("fall_time_before_threshold",	LIBERTY_ATTRENUM_fall_time_before_threshold) ;
("fall_transition_degradation",	LIBERTY_GROUPENUM_fall_transition_degradation) ;
("fall_transition",	LIBERTY_GROUPENUM_fall_transition) ;
("fanout_area",	LIBERTY_ATTRENUM_fanout_area) ;
("fanout_capacitance",	LIBERTY_ATTRENUM_fanout_capacitance) ;
("fanout_length",	LIBERTY_ATTRENUM_fanout_length) ;
("fanout_load",	LIBERTY_ATTRENUM_fanout_load) ;
("fanout_resistance",	LIBERTY_ATTRENUM_fanout_resistance) ;
("faster_factor",	LIBERTY_ATTRENUM_faster_factor) ;
("fault_model",	LIBERTY_ATTRENUM_fault_model) ;
("ff_bank",	LIBERTY_GROUPENUM_ff_bank) ;
("ff",	LIBERTY_GROUPENUM_ff) ;
("force_00",	LIBERTY_ATTRENUM_force_00) ;
("force_01",	LIBERTY_ATTRENUM_force_01) ;
("force_10",	LIBERTY_ATTRENUM_force_10) ;
("force_11",	LIBERTY_ATTRENUM_force_11) ;
("force_inverter_removal",	LIBERTY_ATTRENUM_force_inverter_removal) ;
("fpga_allow_duplicate_degenerated_gates",	LIBERTY_ATTRENUM_fpga_allow_duplicate_degenerated_gates) ;
("fpga_bridge_inputs",	LIBERTY_ATTRENUM_fpga_bridge_inputs) ;
("fpga_cell_type",	LIBERTY_ATTRENUM_fpga_cell_type) ;
("fpga_complex_degenerate",	LIBERTY_ATTRENUM_fpga_complex_degenerate) ;
("fpga_degenerate_output",	LIBERTY_ATTRENUM_fpga_degenerate_output) ;
("fpga_family",	LIBERTY_ATTRENUM_fpga_family) ;
("fpga_lut_insert_before_sequential",	LIBERTY_ATTRENUM_fpga_lut_insert_before_sequential) ;
("fpga_lut_output",	LIBERTY_ATTRENUM_fpga_lut_output) ;
("fpga_max_degen_input_size",	LIBERTY_ATTRENUM_fpga_max_degen_input_size) ;
("fpga_min_degen_input_size",	LIBERTY_ATTRENUM_fpga_min_degen_input_size) ;
("fpga_prefer_undegenerated_gates",	LIBERTY_ATTRENUM_fpga_prefer_undegenerated_gates) ;
("fpga_timing_type",	LIBERTY_ATTRENUM_fpga_timing_type) ;
("fsim_map",	LIBERTY_ATTRENUM_fsim_map) ;
("function",	LIBERTY_ATTRENUM_function) ;
("gate_leakage",	LIBERTY_GROUPENUM_gate_leakage) ;
("generated_clock",	LIBERTY_GROUPENUM_generated_clock) ;
("geometry_print",	LIBERTY_ATTRENUM_geometry_print) ;
("handle_negative_constraint",	LIBERTY_ATTRENUM_handle_negative_constraint) ;
("has_builtin_pad",	LIBERTY_ATTRENUM_has_builtin_pad) ;
("height_coefficient",	LIBERTY_ATTRENUM_height_coefficient) ;
("high",	LIBERTY_ATTRENUM_high) ;
("hold_coefficient",	LIBERTY_ATTRENUM_hold_coefficient) ;
("hyperbolic_noise_above_high",	LIBERTY_GROUPENUM_hyperbolic_noise_above_high) ;
("hyperbolic_noise_below_low",	LIBERTY_GROUPENUM_hyperbolic_noise_below_low) ;
("hyperbolic_noise_high",	LIBERTY_GROUPENUM_hyperbolic_noise_high) ;
("hyperbolic_noise_low",	LIBERTY_GROUPENUM_hyperbolic_noise_low) ;
("hysteresis",	LIBERTY_ATTRENUM_hysteresis) ;
("ignore_verify_icg_type",	LIBERTY_ATTRENUM_ignore_verify_icg_type) ;
("index_1",	LIBERTY_ATTRENUM_index_1) ;
("index_2",	LIBERTY_ATTRENUM_index_2) ;
("index_3",	LIBERTY_ATTRENUM_index_3) ;
("index_4",	LIBERTY_ATTRENUM_index_4) ;
("index_output",	LIBERTY_ATTRENUM_index_output) ;
("init_current",	LIBERTY_GROUPENUM_init_current) ;
("in_place_swap_mode",	LIBERTY_ATTRENUM_in_place_swap_mode) ;
("input_high_value",	LIBERTY_ATTRENUM_input_high_value) ;
("input_low_value",	LIBERTY_ATTRENUM_input_low_value) ;
("input_map",	LIBERTY_ATTRENUM_input_map) ;
("input_map_shift",	LIBERTY_ATTRENUM_input_map_shift) ;
("input_pins",	LIBERTY_ATTRENUM_input_pins) ;
("input_signal_level_high",	LIBERTY_ATTRENUM_input_signal_level_high) ;
("input_signal_level",	LIBERTY_ATTRENUM_input_signal_level) ;
("input_signal_level_low",	LIBERTY_ATTRENUM_input_signal_level_low) ;
("input_signal_swing",	LIBERTY_GROUPENUM_input_signal_swing) ;
("input_switching_condition",	LIBERTY_ATTRENUM_input_switching_condition) ;
("input_threshold_pct_fall",	LIBERTY_ATTRENUM_input_threshold_pct_fall) ;
("input_threshold_pct_rise",	LIBERTY_ATTRENUM_input_threshold_pct_rise) ;
("input_voltage",	LIBERTY_ENUM_input_voltage) ;
("input_voltage_range",	LIBERTY_ATTRENUM_input_voltage_range) ;
("interconnect_delay",	LIBERTY_GROUPENUM_interconnect_delay) ;
("interdependence_id",	LIBERTY_ATTRENUM_interdependence_id) ;
("interface_timing",	LIBERTY_ATTRENUM_interface_timing) ;
("intermediate_values",	LIBERTY_ATTRENUM_intermediate_values) ;
("internal_node",	LIBERTY_ATTRENUM_internal_node) ;
("internal_power",	LIBERTY_GROUPENUM_internal_power) ;
("intrinsic_capacitance",	LIBERTY_GROUPENUM_intrinsic_capacitance) ;
("intrinsic_fall",	LIBERTY_ATTRENUM_intrinsic_fall) ;
("intrinsic_parasitic",	LIBERTY_GROUPENUM_intrinsic_parasitic) ;
("intrinsic_resistance",	LIBERTY_GROUPENUM_intrinsic_resistance) ;
("intrinsic_rise",	LIBERTY_ATTRENUM_intrinsic_rise) ;
("inverted_output",	LIBERTY_ATTRENUM_inverted_output) ;
("invert",	LIBERTY_ATTRENUM_invert) ;
("is_clock_gating_cell",	LIBERTY_ATTRENUM_is_clock_gating_cell) ;
("is_inverting",	LIBERTY_ATTRENUM_is_inverting) ;
("is_isolation_cell",	LIBERTY_ATTRENUM_is_isolation_cell) ;
("is_level_shifter",	LIBERTY_ATTRENUM_is_level_shifter) ;
("is_needed",	LIBERTY_ATTRENUM_is_needed) ;
("isolation_cell_data_pin",	LIBERTY_ATTRENUM_isolation_cell_data_pin) ;
("isolation_cell_enable_pin",	LIBERTY_ATTRENUM_isolation_cell_enable_pin) ;
("is_pad",	LIBERTY_ATTRENUM_is_pad) ;
("is_three_state",	LIBERTY_ATTRENUM_is_three_state) ;
("iv_lut_template",	LIBERTY_GROUPENUM_iv_lut_template) ;
("key_bit",	LIBERTY_ATTRENUM_key_bit) ;
("key_feature",	LIBERTY_ATTRENUM_key_feature) ;
("key_file",	LIBERTY_ATTRENUM_key_file) ;
("key_seed",	LIBERTY_ATTRENUM_key_seed) ;
("key_version",	LIBERTY_ATTRENUM_key_version) ;
("k_process_cell_degradation",	LIBERTY_ATTRENUM_k_process_cell_degradation) ;
("k_process_cell_fall",	LIBERTY_ATTRENUM_k_process_cell_fall) ;
("k_process_cell_leakage_power",	LIBERTY_ATTRENUM_k_process_cell_leakage_power) ;
("k_process_cell_rise",	LIBERTY_ATTRENUM_k_process_cell_rise) ;
("k_process_drive_current",	LIBERTY_ATTRENUM_k_process_drive_current) ;
("k_process_drive_fall",	LIBERTY_ATTRENUM_k_process_drive_fall) ;
("k_process_drive_rise",	LIBERTY_ATTRENUM_k_process_drive_rise) ;
("k_process_fall_delay_intercept",	LIBERTY_ATTRENUM_k_process_fall_delay_intercept) ;
("k_process_fall_pin_resistance",	LIBERTY_ATTRENUM_k_process_fall_pin_resistance) ;
("k_process_fall_propagation",	LIBERTY_ATTRENUM_k_process_fall_propagation) ;
("k_process_fall_transition",	LIBERTY_ATTRENUM_k_process_fall_transition) ;
("k_process_hold_fall",	LIBERTY_ATTRENUM_k_process_hold_fall) ;
("k_process_hold_rise",	LIBERTY_ATTRENUM_k_process_hold_rise) ;
("k_process_internal_power",	LIBERTY_ATTRENUM_k_process_internal_power) ;
("k_process_intrinsic_fall",	LIBERTY_ATTRENUM_k_process_intrinsic_fall) ;
("k_process_intrinsic_rise",	LIBERTY_ATTRENUM_k_process_intrinsic_rise) ;
("k_process_min_period",	LIBERTY_ATTRENUM_k_process_min_period) ;
("k_process_min_pulse_width_high",	LIBERTY_ATTRENUM_k_process_min_pulse_width_high) ;
("k_process_min_pulse_width_low",	LIBERTY_ATTRENUM_k_process_min_pulse_width_low) ;
("k_process_nochange_fall",	LIBERTY_ATTRENUM_k_process_nochange_fall) ;
("k_process_nochange_rise",	LIBERTY_ATTRENUM_k_process_nochange_rise) ;
("k_process_pin_cap",	LIBERTY_ATTRENUM_k_process_pin_cap) ;
("k_process_pin_fall_cap",	LIBERTY_ATTRENUM_k_process_pin_fall_cap) ;
("k_process_pin_rise_cap",	LIBERTY_ATTRENUM_k_process_pin_rise_cap) ;
("k_process_recovery_fall",	LIBERTY_ATTRENUM_k_process_recovery_fall) ;
("k_process_recovery_rise",	LIBERTY_ATTRENUM_k_process_recovery_rise) ;
("k_process_removal_fall",	LIBERTY_ATTRENUM_k_process_removal_fall) ;
("k_process_removal_rise",	LIBERTY_ATTRENUM_k_process_removal_rise) ;
("k_process_rise_delay_intercept",	LIBERTY_ATTRENUM_k_process_rise_delay_intercept) ;
("k_process_rise_pin_resistance",	LIBERTY_ATTRENUM_k_process_rise_pin_resistance) ;
("k_process_rise_propagation",	LIBERTY_ATTRENUM_k_process_rise_propagation) ;
("k_process_rise_transition",	LIBERTY_ATTRENUM_k_process_rise_transition) ;
("k_process_setup_fall",	LIBERTY_ATTRENUM_k_process_setup_fall) ;
("k_process_setup_rise",	LIBERTY_ATTRENUM_k_process_setup_rise) ;
("k_process_skew_fall",	LIBERTY_ATTRENUM_k_process_skew_fall) ;
("k_process_skew_rise",	LIBERTY_ATTRENUM_k_process_skew_rise) ;
("k_process_slope_fall",	LIBERTY_ATTRENUM_k_process_slope_fall) ;
("k_process_slope_rise",	LIBERTY_ATTRENUM_k_process_slope_rise) ;
("k_process_wire_cap",	LIBERTY_ATTRENUM_k_process_wire_cap) ;
("k_process_wire_res",	LIBERTY_ATTRENUM_k_process_wire_res) ;
("k_temp_cell_degradation",	LIBERTY_ATTRENUM_k_temp_cell_degradation) ;
("k_temp_cell_fall",	LIBERTY_ATTRENUM_k_temp_cell_fall) ;
("k_temp_cell_leakage_power",	LIBERTY_ATTRENUM_k_temp_cell_leakage_power) ;
("k_temp_cell_rise",	LIBERTY_ATTRENUM_k_temp_cell_rise) ;
("k_temp_drive_current",	LIBERTY_ATTRENUM_k_temp_drive_current) ;
("k_temp_drive_fall",	LIBERTY_ATTRENUM_k_temp_drive_fall) ;
("k_temp_drive_rise",	LIBERTY_ATTRENUM_k_temp_drive_rise) ;
("k_temp_fall_delay_intercept",	LIBERTY_ATTRENUM_k_temp_fall_delay_intercept) ;
("k_temp_fall_pin_resistance",	LIBERTY_ATTRENUM_k_temp_fall_pin_resistance) ;
("k_temp_fall_propagation",	LIBERTY_ATTRENUM_k_temp_fall_propagation) ;
("k_temp_fall_transition",	LIBERTY_ATTRENUM_k_temp_fall_transition) ;
("k_temp_hold_fall",	LIBERTY_ATTRENUM_k_temp_hold_fall) ;
("k_temp_hold_rise",	LIBERTY_ATTRENUM_k_temp_hold_rise) ;
("k_temp_internal_power",	LIBERTY_ATTRENUM_k_temp_internal_power) ;
("k_temp_intrinsic_fall",	LIBERTY_ATTRENUM_k_temp_intrinsic_fall) ;
("k_temp_intrinsic_rise",	LIBERTY_ATTRENUM_k_temp_intrinsic_rise) ;
("k_temp_min_period",	LIBERTY_ATTRENUM_k_temp_min_period) ;
("k_temp_min_pulse_width_high",	LIBERTY_ATTRENUM_k_temp_min_pulse_width_high) ;
("k_temp_min_pulse_width_low",	LIBERTY_ATTRENUM_k_temp_min_pulse_width_low) ;
("k_temp_nochange_fall",	LIBERTY_ATTRENUM_k_temp_nochange_fall) ;
("k_temp_nochange_rise",	LIBERTY_ATTRENUM_k_temp_nochange_rise) ;
("k_temp_pin_cap",	LIBERTY_ATTRENUM_k_temp_pin_cap) ;
("k_temp_recovery_fall",	LIBERTY_ATTRENUM_k_temp_recovery_fall) ;
("k_temp_recovery_rise",	LIBERTY_ATTRENUM_k_temp_recovery_rise) ;
("k_temp_removal_fall",	LIBERTY_ATTRENUM_k_temp_removal_fall) ;
("k_temp_removal_rise",	LIBERTY_ATTRENUM_k_temp_removal_rise) ;
("k_temp_rise_delay_intercept",	LIBERTY_ATTRENUM_k_temp_rise_delay_intercept) ;
("k_temp_rise_pin_resistance",	LIBERTY_ATTRENUM_k_temp_rise_pin_resistance) ;
("k_temp_rise_propagation",	LIBERTY_ATTRENUM_k_temp_rise_propagation) ;
("k_temp_rise_transition",	LIBERTY_ATTRENUM_k_temp_rise_transition) ;
("k_temp_setup_fall",	LIBERTY_ATTRENUM_k_temp_setup_fall) ;
("k_temp_setup_rise",	LIBERTY_ATTRENUM_k_temp_setup_rise) ;
("k_temp_skew_fall",	LIBERTY_ATTRENUM_k_temp_skew_fall) ;
("k_temp_skew_rise",	LIBERTY_ATTRENUM_k_temp_skew_rise) ;
("k_temp_slope_fall",	LIBERTY_ATTRENUM_k_temp_slope_fall) ;
("k_temp_slope_rise",	LIBERTY_ATTRENUM_k_temp_slope_rise) ;
("k_temp_wire_cap",	LIBERTY_ATTRENUM_k_temp_wire_cap) ;
("k_temp_wire_res",	LIBERTY_ATTRENUM_k_temp_wire_res) ;
("k_volt_cell_degradation",	LIBERTY_ATTRENUM_k_volt_cell_degradation) ;
("k_volt_cell_fall",	LIBERTY_ATTRENUM_k_volt_cell_fall) ;
("k_volt_cell_leakage_power",	LIBERTY_ATTRENUM_k_volt_cell_leakage_power) ;
("k_volt_cell_rise",	LIBERTY_ATTRENUM_k_volt_cell_rise) ;
("k_volt_drive_current",	LIBERTY_ATTRENUM_k_volt_drive_current) ;
("k_volt_drive_fall",	LIBERTY_ATTRENUM_k_volt_drive_fall) ;
("k_volt_drive_rise",	LIBERTY_ATTRENUM_k_volt_drive_rise) ;
("k_volt_fall_delay_intercept",	LIBERTY_ATTRENUM_k_volt_fall_delay_intercept) ;
("k_volt_fall_pin_resistance",	LIBERTY_ATTRENUM_k_volt_fall_pin_resistance) ;
("k_volt_fall_propagation",	LIBERTY_ATTRENUM_k_volt_fall_propagation) ;
("k_volt_fall_transition",	LIBERTY_ATTRENUM_k_volt_fall_transition) ;
("k_volt_hold_fall",	LIBERTY_ATTRENUM_k_volt_hold_fall) ;
("k_volt_hold_rise",	LIBERTY_ATTRENUM_k_volt_hold_rise) ;
("k_volt_internal_power",	LIBERTY_ATTRENUM_k_volt_internal_power) ;
("k_volt_intrinsic_fall",	LIBERTY_ATTRENUM_k_volt_intrinsic_fall) ;
("k_volt_intrinsic_rise",	LIBERTY_ATTRENUM_k_volt_intrinsic_rise) ;
("k_volt_min_period",	LIBERTY_ATTRENUM_k_volt_min_period) ;
("k_volt_min_pulse_width_high",	LIBERTY_ATTRENUM_k_volt_min_pulse_width_high) ;
("k_volt_min_pulse_width_low",	LIBERTY_ATTRENUM_k_volt_min_pulse_width_low) ;
("k_volt_nochange_fall",	LIBERTY_ATTRENUM_k_volt_nochange_fall) ;
("k_volt_nochange_rise",	LIBERTY_ATTRENUM_k_volt_nochange_rise) ;
("k_volt_pin_cap",	LIBERTY_ATTRENUM_k_volt_pin_cap) ;
("k_volt_recovery_fall",	LIBERTY_ATTRENUM_k_volt_recovery_fall) ;
("k_volt_recovery_rise",	LIBERTY_ATTRENUM_k_volt_recovery_rise) ;
("k_volt_removal_fall",	LIBERTY_ATTRENUM_k_volt_removal_fall) ;
("k_volt_removal_rise",	LIBERTY_ATTRENUM_k_volt_removal_rise) ;
("k_volt_rise_delay_intercept",	LIBERTY_ATTRENUM_k_volt_rise_delay_intercept) ;
("k_volt_rise_pin_resistance",	LIBERTY_ATTRENUM_k_volt_rise_pin_resistance) ;
("k_volt_rise_propagation",	LIBERTY_ATTRENUM_k_volt_rise_propagation) ;
("k_volt_rise_transition",	LIBERTY_ATTRENUM_k_volt_rise_transition) ;
("k_volt_setup_fall",	LIBERTY_ATTRENUM_k_volt_setup_fall) ;
("k_volt_setup_rise",	LIBERTY_ATTRENUM_k_volt_setup_rise) ;
("k_volt_skew_fall",	LIBERTY_ATTRENUM_k_volt_skew_fall) ;
("k_volt_skew_rise",	LIBERTY_ATTRENUM_k_volt_skew_rise) ;
("k_volt_slope_fall",	LIBERTY_ATTRENUM_k_volt_slope_fall) ;
("k_volt_slope_rise",	LIBERTY_ATTRENUM_k_volt_slope_rise) ;
("k_volt_wire_cap",	LIBERTY_ATTRENUM_k_volt_wire_cap) ;
("k_volt_wire_res",	LIBERTY_ATTRENUM_k_volt_wire_res) ;
("latch_bank",	LIBERTY_GROUPENUM_latch_bank) ;
("latch",	LIBERTY_GROUPENUM_latch) ;
("leakage_current",	LIBERTY_GROUPENUM_leakage_current) ;
("leakage_power",	LIBERTY_GROUPENUM_leakage_power) ;
("leakage_power_unit",	LIBERTY_ATTRENUM_leakage_power_unit) ;
("left_id",	LIBERTY_GROUPENUM_left_id) ;
("level_shifter_data_pin",	LIBERTY_ATTRENUM_level_shifter_data_pin) ;
("level_shifter_enable_pin",	LIBERTY_ATTRENUM_level_shifter_enable_pin) ;
("level_shifter_type",	LIBERTY_ATTRENUM_level_shifter_type) ;
("library_features",	LIBERTY_ATTRENUM_library_features) ;
("library",	LIBERTY_GROUPENUM_library);
("lower",	LIBERTY_GROUPENUM_lower) ;
("low",	LIBERTY_ATTRENUM_low) ;
("lsi_pad_fall",	LIBERTY_ATTRENUM_lsi_pad_fall) ;
("lsi_pad",	LIBERTY_ATTRENUM_lsi_pad) ;
("lsi_pad_rise",	LIBERTY_ATTRENUM_lsi_pad_rise) ;
("lsi_rounding_cutoff",	LIBERTY_ATTRENUM_lsi_rounding_cutoff) ;
("lsi_rounding_digit",	LIBERTY_ATTRENUM_lsi_rounding_digit) ;
("lu_table_template",	LIBERTY_GROUPENUM_lu_table_template) ;
("lut",	LIBERTY_GROUPENUM_lut) ;
("map_only",	LIBERTY_ATTRENUM_map_only) ;
("mapping",	LIBERTY_ATTRENUM_mapping) ;
("map_to_logic",	LIBERTY_ATTRENUM_map_to_logic) ;
("master_pin",	LIBERTY_ATTRENUM_master_pin) ;
("max_capacitance",	LIBERTY_ATTRENUM_max_capacitance) ;
("max_cap",	LIBERTY_GROUPENUM_max_cap) ;
("maxcap_lut_template",	LIBERTY_GROUPENUM_maxcap_lut_template) ;
("max_fanout",	LIBERTY_ATTRENUM_max_fanout) ;
("max_input_noise_width",	LIBERTY_ATTRENUM_max_input_noise_width) ;
("max_time_borrow",	LIBERTY_ATTRENUM_max_time_borrow) ;
("max_transition",	LIBERTY_ATTRENUM_max_transition) ;
("max_trans",	LIBERTY_GROUPENUM_max_trans) ;
("maxtrans_lut_template",	LIBERTY_GROUPENUM_maxtrans_lut_template) ;
("members",	LIBERTY_ATTRENUM_members) ;
("memory",	LIBERTY_GROUPENUM_memory) ;
("memory_read",	LIBERTY_GROUPENUM_memory_read) ;
("memory_write",	LIBERTY_GROUPENUM_memory_write) ;
("miller_cap_fall",	LIBERTY_ATTRENUM_miller_cap_fall) ;
("miller_cap_rise",	LIBERTY_ATTRENUM_miller_cap_rise) ;
("min_capacitance",	LIBERTY_ATTRENUM_min_capacitance) ;
("min_fanout",	LIBERTY_ATTRENUM_min_fanout) ;
("minimum_period",	LIBERTY_GROUPENUM_minimum_period) ;
("min_input_noise_width",	LIBERTY_ATTRENUM_min_input_noise_width) ;
("min_period",	LIBERTY_ATTRENUM_min_period) ;
("min_pulse_width_high",	LIBERTY_ATTRENUM_min_pulse_width_high) ;
("min_pulse_width",	LIBERTY_GROUPENUM_min_pulse_width) ;
("min_pulse_width_low",	LIBERTY_ATTRENUM_min_pulse_width_low) ;
("min_transition",	LIBERTY_ATTRENUM_min_transition) ;
("mode_definition",	LIBERTY_GROUPENUM_mode_definition) ;
("mode",	LIBERTY_ATTRENUM_mode) ;
("model",	LIBERTY_GROUPENUM_model) ;
("mode_value",	LIBERTY_GROUPENUM_mode_value) ;
("mpm_libname",	LIBERTY_ATTRENUM_mpm_libname) ;
("mpm_name",	LIBERTY_ATTRENUM_mpm_name) ;
("multicell_pad_pin",	LIBERTY_ATTRENUM_multicell_pad_pin) ;
("multiplied_by",	LIBERTY_ATTRENUM_multiplied_by) ;
("next_state",	LIBERTY_ATTRENUM_next_state) ;
("nextstate_type",	LIBERTY_ATTRENUM_nextstate_type) ;
("noise_immunity_above_high",	LIBERTY_GROUPENUM_noise_immunity_above_high) ;
("noise_immunity_below_low",	LIBERTY_GROUPENUM_noise_immunity_below_low) ;
("noise_immunity_high",	LIBERTY_GROUPENUM_noise_immunity_high) ;
("noise_immunity_low",	LIBERTY_GROUPENUM_noise_immunity_low) ;
("noise_lut_template",	LIBERTY_GROUPENUM_noise_lut_template) ;
("nom_calc_mode",	LIBERTY_ATTRENUM_nom_calc_mode) ;
("nominal_va_values",	LIBERTY_ATTRENUM_nominal_va_values) ;
("nom_process",	LIBERTY_ATTRENUM_nom_process) ;
("nom_temperature",	LIBERTY_ATTRENUM_nom_temperature) ;
("nom_voltage",	LIBERTY_ATTRENUM_nom_voltage) ;
("normalized_driver_waveform",	LIBERTY_GROUPENUM_normalized_driver_waveform) ;
("observe_node",	LIBERTY_ATTRENUM_observe_node) ;
("operating_conditions",	LIBERTY_GROUPENUM_operating_conditions) ;
("orders",	LIBERTY_ATTRENUM_orders) ;
("output_current_fall",	LIBERTY_GROUPENUM_output_current_fall) ;
("output_current_rise",	LIBERTY_GROUPENUM_output_current_rise) ;
("output_current_template",	LIBERTY_GROUPENUM_output_current_template) ;
("output_signal_level_high",	LIBERTY_ATTRENUM_output_signal_level_high) ;
("output_signal_level",	LIBERTY_ATTRENUM_output_signal_level) ;
("output_signal_level_low",	LIBERTY_ATTRENUM_output_signal_level_low) ;
("output_signal_swing",	LIBERTY_GROUPENUM_output_signal_swing) ;
("output_switching_condition",	LIBERTY_ATTRENUM_output_switching_condition) ;
("output_threshold_pct_fall",	LIBERTY_ATTRENUM_output_threshold_pct_fall) ;
("output_threshold_pct_rise",	LIBERTY_ATTRENUM_output_threshold_pct_rise) ;
("output_voltage_fall",	LIBERTY_GROUPENUM_output_voltage_fall) ;
("output_voltage",	LIBERTY_ENUM_output_voltage) ;
("output_voltage_range",	LIBERTY_ATTRENUM_output_voltage_range) ;
("output_voltage_rise",	LIBERTY_GROUPENUM_output_voltage_rise) ;
("pad_cell",	LIBERTY_ATTRENUM_pad_cell) ;
("pad_type",	LIBERTY_ATTRENUM_pad_type) ;
("parameter1",	LIBERTY_ATTRENUM_parameter1) ;
("parameter2",	LIBERTY_ATTRENUM_parameter2) ;
("parameter3",	LIBERTY_ATTRENUM_parameter3) ;
("parameter4",	LIBERTY_ATTRENUM_parameter4) ;
("parameter5",	LIBERTY_ATTRENUM_parameter5) ;
("peak_current",	LIBERTY_GROUPENUM_peak_current) ;
("peak_time",	LIBERTY_GROUPENUM_peak_time) ;
("peak_voltage",	LIBERTY_GROUPENUM_peak_voltage) ;
("pg_current",	LIBERTY_GROUPENUM_pg_current) ;
("pg_current_template",	LIBERTY_GROUPENUM_pg_current_template) ;
("pg_function",	LIBERTY_ATTRENUM_pg_function) ;
("pg_pin",	LIBERTY_GROUPENUM_pg_pin) ;
("pg_type",	LIBERTY_ATTRENUM_pg_type) ;
("piece_define",	LIBERTY_ATTRENUM_piece_define) ;
("piece_type",	LIBERTY_ATTRENUM_piece_type) ;
("pin_based_variation",	LIBERTY_GROUPENUM_pin_based_variation) ;
("pin_capacitance",	LIBERTY_GROUPENUM_pin_capacitance) ;
("pin_equal",	LIBERTY_ATTRENUM_pin_equal) ;
("pin_func_type",	LIBERTY_ATTRENUM_pin_func_type) ;
("pin",	LIBERTY_GROUPENUM_pin) ;
("pin_name_map",	LIBERTY_ATTRENUM_pin_name_map) ;
("pin_names",	LIBERTY_ATTRENUM_pin_names) ;
("pin_opposite",	LIBERTY_ATTRENUM_pin_opposite) ;
("poly_convert",	LIBERTY_ATTRENUM_poly_convert) ;
("poly_template",	LIBERTY_GROUPENUM_poly_template) ;
("power_down_function",	LIBERTY_ATTRENUM_power_down_function) ;
("power_gating_cell",	LIBERTY_ATTRENUM_power_gating_cell) ;
("power_gating_pin",	LIBERTY_ATTRENUM_power_gating_pin) ;
("power_level",	LIBERTY_ATTRENUM_power_level) ;
("power",	LIBERTY_GROUPENUM_power) ;
("power_lut_template",	LIBERTY_GROUPENUM_power_lut_template) ;
("power_model",	LIBERTY_ATTRENUM_power_model) ;
("power_poly_template",	LIBERTY_GROUPENUM_power_poly_template) ;
("power_rail",	LIBERTY_ATTRENUM_power_rail) ;
("power_supply",	LIBERTY_GROUPENUM_power_supply) ;
("preferred_input_pad_voltage",	LIBERTY_ATTRENUM_preferred_input_pad_voltage) ;
("preferred",	LIBERTY_ATTRENUM_preferred) ;
("preferred_output_pad_slew_rate_control",	LIBERTY_ATTRENUM_preferred_output_pad_slew_rate_control) ;
("preferred_output_pad_voltage",	LIBERTY_ATTRENUM_preferred_output_pad_voltage) ;
("prefer_tied",	LIBERTY_ATTRENUM_prefer_tied) ;
("preset",	LIBERTY_ATTRENUM_preset) ;
("primary_output",	LIBERTY_ATTRENUM_primary_output) ;
("process",	LIBERTY_ATTRENUM_process) ;
("propagated_noise_height_above_high",	LIBERTY_GROUPENUM_propagated_noise_height_above_high) ;
("propagated_noise_height_below_low",	LIBERTY_GROUPENUM_propagated_noise_height_below_low) ;
("propagated_noise_height_high",	LIBERTY_GROUPENUM_propagated_noise_height_high) ;
("propagated_noise_height_low",	LIBERTY_GROUPENUM_propagated_noise_height_low) ;
("propagated_noise_high",	LIBERTY_GROUPENUM_propagated_noise_high) ;
("propagated_noise_low",	LIBERTY_GROUPENUM_propagated_noise_low) ;
("propagated_noise_peak_time_ratio_above_high",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_above_high) ;
("propagated_noise_peak_time_ratio_below_low",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_below_low) ;
("propagated_noise_peak_time_ratio_high",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_high) ;
("propagated_noise_peak_time_ratio_low",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_low) ;
("propagated_noise_width_above_high",	LIBERTY_GROUPENUM_propagated_noise_width_above_high) ;
("propagated_noise_width_below_low",	LIBERTY_GROUPENUM_propagated_noise_width_below_low) ;
("propagated_noise_width_high",	LIBERTY_GROUPENUM_propagated_noise_width_high) ;
("propagated_noise_width_low",	LIBERTY_GROUPENUM_propagated_noise_width_low) ;
("propagation_lut_template",	LIBERTY_GROUPENUM_propagation_lut_template) ;
("pulling_current",	LIBERTY_ATTRENUM_pulling_current) ;
("pulling_resistance",	LIBERTY_ATTRENUM_pulling_resistance) ;
("pulling_resistance_unit",	LIBERTY_ATTRENUM_pulling_resistance_unit) ;
("rail_connection",	LIBERTY_ATTRENUM_rail_connection) ;
("receiver_capacitance1_fall",	LIBERTY_GROUPENUM_receiver_capacitance1_fall) ;
("receiver_capacitance1_rise",	LIBERTY_GROUPENUM_receiver_capacitance1_rise) ;
("receiver_capacitance2_fall",	LIBERTY_GROUPENUM_receiver_capacitance2_fall) ;
("receiver_capacitance2_rise",	LIBERTY_GROUPENUM_receiver_capacitance2_rise) ;
("receiver_capacitance",	LIBERTY_GROUPENUM_receiver_capacitance) ;
("reference_capacitance",	LIBERTY_ATTRENUM_reference_capacitance) ;
("reference_time",	LIBERTY_ATTRENUM_reference_time) ;
("related_bus_equivalent",	LIBERTY_ATTRENUM_related_bus_equivalent) ;
("related_bus_pins",	LIBERTY_ATTRENUM_related_bus_pins) ;
("related_falling_pin",	LIBERTY_ATTRENUM_related_falling_pin) ;
("related_ground_pin",	LIBERTY_ATTRENUM_related_ground_pin) ;
("related_input",	LIBERTY_ATTRENUM_related_input) ;
("related_inputs",	LIBERTY_ATTRENUM_related_inputs) ;
("related_internal_pg_pin",	LIBERTY_ATTRENUM_related_internal_pg_pin) ;
("related_output",	LIBERTY_ATTRENUM_related_output) ;
("related_output_pin",	LIBERTY_ATTRENUM_related_output_pin) ;
("related_outputs",	LIBERTY_ATTRENUM_related_outputs) ;
("related_pg_pin",	LIBERTY_ATTRENUM_related_pg_pin) ;
("related_pin",	LIBERTY_ATTRENUM_related_pin) ;
("related_power_pin",	LIBERTY_ATTRENUM_related_power_pin) ;
("related_rising_pin",	LIBERTY_ATTRENUM_related_rising_pin) ;
("related_switch_pin",	LIBERTY_ATTRENUM_related_switch_pin) ;
("resistance",	LIBERTY_ATTRENUM_resistance) ;
("resistance_unit",	LIBERTY_ATTRENUM_resistance_unit) ;
("retain_fall_slew",	LIBERTY_GROUPENUM_retain_fall_slew) ;
("retaining_fall",	LIBERTY_GROUPENUM_retaining_fall) ;
("retaining_rise",	LIBERTY_GROUPENUM_retaining_rise) ;
("retain_rise_slew",	LIBERTY_GROUPENUM_retain_rise_slew) ;
("retention_cell",	LIBERTY_ATTRENUM_retention_cell) ;
("retention_pin",	LIBERTY_ATTRENUM_retention_pin) ;
("revision",	LIBERTY_ATTRENUM_revision) ;
("right_id",	LIBERTY_GROUPENUM_right_id) ;
("rise_capacitance",	LIBERTY_ENUM_rise_capacitance) ;
("rise_capacitance_range",	LIBERTY_ENUM_rise_capacitance_range) ;
("rise_constraint",	LIBERTY_GROUPENUM_rise_constraint) ;
("rise_current_slope_after_threshold",	LIBERTY_ATTRENUM_rise_current_slope_after_threshold) ;
("rise_current_slope_before_threshold",	LIBERTY_ATTRENUM_rise_current_slope_before_threshold) ;
("rise_delay_intercept",	LIBERTY_ATTRENUM_rise_delay_intercept) ;
("rise_net_delay",	LIBERTY_GROUPENUM_rise_net_delay) ;
("rise_pin_resistance",	LIBERTY_ATTRENUM_rise_pin_resistance) ;
("rise_power",	LIBERTY_GROUPENUM_rise_power) ;
("rise_propagation",	LIBERTY_GROUPENUM_rise_propagation) ;
("rise_resistance",	LIBERTY_ATTRENUM_rise_resistance) ;
("rise_time_after_threshold",	LIBERTY_ATTRENUM_rise_time_after_threshold) ;
("rise_time_before_threshold",	LIBERTY_ATTRENUM_rise_time_before_threshold) ;
("rise_transition_degradation",	LIBERTY_GROUPENUM_rise_transition_degradation) ;
("rise_transition",	LIBERTY_GROUPENUM_rise_transition) ;
("rising_together_group",	LIBERTY_ATTRENUM_rising_together_group) ;
("routing_layers",	LIBERTY_ATTRENUM_routing_layers) ;
("routing_track",	LIBERTY_GROUPENUM_routing_track) ;
("row_address",	LIBERTY_ATTRENUM_row_address) ;
("scaled_cell",	LIBERTY_GROUPENUM_scaled_cell) ;
("scaling_factors",	LIBERTY_ENUM_scaling_factors) ;
("scan_group",	LIBERTY_ATTRENUM_scan_group) ;
("sdf_cond_end",	LIBERTY_ATTRENUM_sdf_cond_end) ;
("sdf_cond",	LIBERTY_ATTRENUM_sdf_cond) ;
("sdf_cond_start",	LIBERTY_ATTRENUM_sdf_cond_start) ;
("sdf_edges",	LIBERTY_ATTRENUM_sdf_edges) ;
("sensitization",	LIBERTY_GROUPENUM_sensitization) ;
("sensitization_master",	LIBERTY_ATTRENUM_sensitization_master) ;
("seq_bank",	LIBERTY_GROUPENUM_seq_bank) ;
("seq",	LIBERTY_GROUPENUM_seq) ;
("set_node",	LIBERTY_ATTRENUM_set_node) ;
("setup_coefficient",	LIBERTY_ATTRENUM_setup_coefficient) ;
("shifts",	LIBERTY_ATTRENUM_shifts) ;
("short",	LIBERTY_ATTRENUM_short) ;
("signal_type",	LIBERTY_ATTRENUM_signal_type) ;
("simulation",	LIBERTY_ATTRENUM_simulation) ;
("single_bit_degenerate",	LIBERTY_ATTRENUM_single_bit_degenerate) ;
("slew_control",	LIBERTY_ATTRENUM_slew_control) ;
("slew_derate_from_library",	LIBERTY_ATTRENUM_slew_derate_from_library) ;
("slew_lower_threshold_pct_fall",	LIBERTY_ATTRENUM_slew_lower_threshold_pct_fall) ;
("slew_lower_threshold_pct_rise",	LIBERTY_ATTRENUM_slew_lower_threshold_pct_rise) ;
("slew_upper_threshold_pct_fall",	LIBERTY_ATTRENUM_slew_upper_threshold_pct_fall) ;
("slew_upper_threshold_pct_rise",	LIBERTY_ATTRENUM_slew_upper_threshold_pct_rise) ;
("slope_fall",	LIBERTY_ATTRENUM_slope_fall) ;
("slope",	LIBERTY_ATTRENUM_slope) ;
("slope_rise",	LIBERTY_ATTRENUM_slope_rise) ;
("slower_factor",	LIBERTY_ATTRENUM_slower_factor) ;
("stage_type",	LIBERTY_ATTRENUM_stage_type) ;
("state_function",	LIBERTY_ATTRENUM_state_function) ;
("state",	LIBERTY_GROUPENUM_state) ;
("statetable",	LIBERTY_GROUPENUM_statetable) ;
("std_cell_main_rail",	LIBERTY_ATTRENUM_std_cell_main_rail) ;
("steady_state_current_high",	LIBERTY_GROUPENUM_steady_state_current_high) ;
("steady_state_current_low",	LIBERTY_GROUPENUM_steady_state_current_low) ;
("steady_state_current_tristate",	LIBERTY_GROUPENUM_steady_state_current_tristate) ;
("steady_state_resistance_above_high",	LIBERTY_ATTRENUM_steady_state_resistance_above_high) ;
("steady_state_resistance_below_low",	LIBERTY_ATTRENUM_steady_state_resistance_below_low) ;
("steady_state_resistance_float_max",	LIBERTY_ATTRENUM_steady_state_resistance_float_max) ;
("steady_state_resistance_float_min",	LIBERTY_ATTRENUM_steady_state_resistance_float_min) ;
("steady_state_resistance_high",	LIBERTY_ATTRENUM_steady_state_resistance_high) ;
("steady_state_resistance_high_max",	LIBERTY_ATTRENUM_steady_state_resistance_high_max) ;
("steady_state_resistance_high_min",	LIBERTY_ATTRENUM_steady_state_resistance_high_min) ;
("steady_state_resistance_low",	LIBERTY_ATTRENUM_steady_state_resistance_low) ;
("steady_state_resistance_low_max",	LIBERTY_ATTRENUM_steady_state_resistance_low_max) ;
("steady_state_resistance_low_min",	LIBERTY_ATTRENUM_steady_state_resistance_low_min) ;
("switch_cell_type",	LIBERTY_ATTRENUM_switch_cell_type) ;
("switch_function",	LIBERTY_ATTRENUM_switch_function) ;
("switching_group",	LIBERTY_GROUPENUM_switching_group) ;
("switching_interval",	LIBERTY_ATTRENUM_switching_interval) ;
("switching_together_group",	LIBERTY_ATTRENUM_switching_together_group) ;
("switch_pin",	LIBERTY_ATTRENUM_switch_pin) ;
("table",	LIBERTY_ATTRENUM_table) ;
("tdisable",	LIBERTY_ATTRENUM_tdisable) ;
("technology",	LIBERTY_ATTRENUM_technology) ;
("temperature",	LIBERTY_ATTRENUM_temperature) ;
("test_cell",	LIBERTY_GROUPENUM_test_cell) ;
("test_output_only",	LIBERTY_ATTRENUM_test_output_only) ;
("three_state",	LIBERTY_ATTRENUM_three_state) ;
("threshold",	LIBERTY_ATTRENUM_threshold) ;
("threshold_voltage_group",	LIBERTY_ATTRENUM_threshold_voltage_group) ;
("tied_off",	LIBERTY_ATTRENUM_tied_off) ;
("time_unit",	LIBERTY_ATTRENUM_time_unit) ;
("timing_based_variation",	LIBERTY_GROUPENUM_timing_based_variation) ;
("timing",	LIBERTY_GROUPENUM_timing) ;
("timing_model_type",	LIBERTY_ATTRENUM_timing_model_type) ;
("timing_range",	LIBERTY_GROUPENUM_timing_range) ;
("timing_report",	LIBERTY_ATTRENUM_timing_report) ;
("timing_sense",	LIBERTY_ATTRENUM_timing_sense) ;
("timing_type",	LIBERTY_ATTRENUM_timing_type) ;
("tlatch",	LIBERTY_GROUPENUM_tlatch) ;
("total_track_area",	LIBERTY_ATTRENUM_total_track_area) ;
("tracks",	LIBERTY_ATTRENUM_tracks) ;
("tree_type",	LIBERTY_ATTRENUM_tree_type) ;
("type",	LIBERTY_ENUM_type) ;
("typical_capacitances",	LIBERTY_ATTRENUM_typical_capacitances) ;
("upper",	LIBERTY_GROUPENUM_upper) ;
("use_for_size_only",	LIBERTY_ATTRENUM_use_for_size_only) ;
("user_function_class",	LIBERTY_ATTRENUM_user_function_class) ;
("user_parameters",	LIBERTY_GROUPENUM_user_parameters) ;
("va_compact_ccs_fall",	LIBERTY_GROUPENUM_va_compact_ccs_fall) ;
("va_compact_ccs_rise",	LIBERTY_GROUPENUM_va_compact_ccs_rise) ;
("va_fall_constraint",	LIBERTY_GROUPENUM_va_fall_constraint) ;
("value",	LIBERTY_ATTRENUM_value) ;
("values",	LIBERTY_ATTRENUM_values) ;
("va_parameters",	LIBERTY_ATTRENUM_va_parameters) ;
("va_receiver_capacitance1_fall",	LIBERTY_GROUPENUM_va_receiver_capacitance1_fall) ;
("va_receiver_capacitance1_rise",	LIBERTY_GROUPENUM_va_receiver_capacitance1_rise) ;
("va_receiver_capacitance2_fall",	LIBERTY_GROUPENUM_va_receiver_capacitance2_fall) ;
("va_receiver_capacitance2_rise",	LIBERTY_GROUPENUM_va_receiver_capacitance2_rise) ;
("variable_1",	LIBERTY_ATTRENUM_variable_1) ;
("variable_1_range",	LIBERTY_ATTRENUM_variable_1_range) ;
("variable_2",	LIBERTY_ATTRENUM_variable_2) ;
("variable_2_range",	LIBERTY_ATTRENUM_variable_2_range) ;
("variable_3",	LIBERTY_ATTRENUM_variable_3) ;
("variable_3_range",	LIBERTY_ATTRENUM_variable_3_range) ;
("variable_4",	LIBERTY_ATTRENUM_variable_4) ;
("variable_4_range",	LIBERTY_ATTRENUM_variable_4_range) ;
("variable_5_range",	LIBERTY_ATTRENUM_variable_5_range) ;
("variable_6_range",	LIBERTY_ATTRENUM_variable_6_range) ;
("variable_7_range",	LIBERTY_ATTRENUM_variable_7_range) ;
("variables",	LIBERTY_ATTRENUM_variables) ;
("va_rise_constraint",	LIBERTY_GROUPENUM_va_rise_constraint) ;
("va_values",	LIBERTY_ATTRENUM_va_values) ;
("vector",	LIBERTY_ENUM_vector) ;
("vhdl_name",	LIBERTY_ATTRENUM_vhdl_name) ;
("vih",	LIBERTY_ATTRENUM_vih) ;
("vil",	LIBERTY_ATTRENUM_vil) ;
("vimax",	LIBERTY_ATTRENUM_vimax) ;
("vimin",	LIBERTY_ATTRENUM_vimin) ;
("voh",	LIBERTY_ATTRENUM_voh) ;
("vol",	LIBERTY_ATTRENUM_vol) ;
("voltage",	LIBERTY_ATTRENUM_voltage) ;
("voltage_map",	LIBERTY_ATTRENUM_voltage_map) ;
("voltage_name",	LIBERTY_ATTRENUM_voltage_name) ;
("voltage_unit",	LIBERTY_ATTRENUM_voltage_unit) ;
("vomax",	LIBERTY_ATTRENUM_vomax) ;
("vomin",	LIBERTY_ATTRENUM_vomin) ;
("wave_fall",	LIBERTY_ATTRENUM_wave_fall) ;
("wave_rise",	LIBERTY_ATTRENUM_wave_rise) ;
("when_end",	LIBERTY_ATTRENUM_when_end) ;
("when",	LIBERTY_ATTRENUM_when) ;
("when_start",	LIBERTY_ATTRENUM_when_start) ;
("width_coefficient",	LIBERTY_ATTRENUM_width_coefficient) ;
("wire_load_from_area",	LIBERTY_ATTRENUM_wire_load_from_area) ;
("wire_load",	LIBERTY_GROUPENUM_wire_load) ;
("wire_load_selection",	LIBERTY_GROUPENUM_wire_load_selection) ;
("wire_load_table",	LIBERTY_GROUPENUM_wire_load_table) ;
("word_width",	LIBERTY_ATTRENUM_word_width) ;
("x_function",	LIBERTY_ATTRENUM_x_function) ;
("xnf_device_name",	LIBERTY_ATTRENUM_xnf_device_name) ;
("xnf_schnm",	LIBERTY_ATTRENUM_xnf_schnm) ];;
}

let digit = ['0'-'9']
let state4 = ['0'-'1' 'x' 'z' '?' 'X' 'Z' 'b' 'B']
let ident = ['a'-'z' 'A'-'Z' '_']
let ident_num_other = ['a'-'z' 'A'-'Z' '_' '0'-'9' '[' ':' ']' '.']
let anything_but_newline = [ '\r' '\t' ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_quote = [ '\r' '\n' ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]

rule token = parse
|  '\\''\n' {token lexbuf }
| '\"'[^ '\"']*'\"' as asciinum { hlog lexbuf (STRING asciinum ) }
| "/*"
    { comment (Lexing.lexeme_start lexbuf) lexbuf; token lexbuf }
|  "//"anything_but_newline* {token lexbuf}
| ":" { hlog lexbuf (COLON) }
| "," { hlog lexbuf (COMMA) }
| "[" { hlog lexbuf (LBRACK) }
| "{" { hlog lexbuf (LCURLY) }
| "(" { hlog lexbuf (LPAR) }
| "-" { hlog lexbuf (MINUS) }
| "+" { hlog lexbuf (PLUS) }
| "]" { hlog lexbuf (RBRACK) }
| "}" { hlog lexbuf (RCURLY) }
| ")" { hlog lexbuf (RPAR) }
| ";" { hlog lexbuf (SEMI) }
| "$" ident ident_num_other* as word {
if Hashtbl.mem ksymbols word then hlog lexbuf (ID (Hashtbl.find ksymbols word)) else hlog lexbuf (ID (STRING word))
}
| digit+'.'digit*['e' 'E']['+' '-' '0'-'9']digit* as floatnum { hlog lexbuf ( NUM ( float_of_string floatnum ) ) }
| digit+['e' 'E']['+' '-' '0'-'9']digit* as floatnum { hlog lexbuf ( NUM ( float_of_string floatnum ) ) }
| digit+'.'digit* as floatnum { hlog lexbuf ( NUM ( float_of_string floatnum ) ) }
| digit ident ident_num_other* as word { hlog lexbuf (ID (STRING word)) }
| digit+ as intnum { hlog lexbuf ( NUM ( float_of_string intnum ) ) }
| ident ident_num_other* as word {
if Hashtbl.mem ksymbols word then hlog lexbuf (ID (Hashtbl.find ksymbols word)) else hlog lexbuf (ID (STRING word))
}
  | [' ' '\t' ]		{token lexbuf }
  | ['\r' '\n' ]	{token lexbuf }
  | _		{ hlog lexbuf (STRING (String.make 1 ( lexeme_char lexbuf 0 ))) }
  | eof		{ hlog lexbuf (ENDOFFILE) }

and comment start = parse
  "/*"
    { comment (Lexing.lexeme_start lexbuf) lexbuf; comment start lexbuf }
| "*/"
    { () }
| eof
    { failwith (Printf.sprintf "Unterminated /* comment */ at offset %d." start) }
| _
    { comment start lexbuf }

and comment2 start = parse
  "(*"
    { comment2 (Lexing.lexeme_start lexbuf) lexbuf; comment2 start lexbuf }
| "*)"
    { () }
| eof
    { failwith (Printf.sprintf "Unterminated (* comment *) at offset %d." start) }
| _
    { comment2 start lexbuf }
