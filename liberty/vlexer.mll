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
Printf.printf "Trace %d : %s (%d-%d)\n"  !histcnt (str_token (item.tok)) item.strt item.stop;
ignore(histcnt := (!histcnt+1)mod hsiz);
ktok
end

let _ = List.iter (fun (str,key) -> enter_keyword str key)
[
(*
("input_pins",	LIBERTY_ATTRENUM_input_pins) ;
("fpga_timing_type",	LIBERTY_ATTRENUM_fpga_timing_type) ;
("fpga_degenerate_output",	LIBERTY_ATTRENUM_fpga_degenerate_output) ;
("xnf_schnm",	LIBERTY_ATTRENUM_xnf_schnm) ;
("xnf_device_name",	LIBERTY_ATTRENUM_xnf_device_name) ;
("fpga_min_degen_input_size",	LIBERTY_ATTRENUM_fpga_min_degen_input_size) ;
("fpga_max_degen_input_size",	LIBERTY_ATTRENUM_fpga_max_degen_input_size) ;
("fpga_lut_output",	LIBERTY_ATTRENUM_fpga_lut_output) ;
("fpga_lut_insert_before_sequential",	LIBERTY_ATTRENUM_fpga_lut_insert_before_sequential) ;
("fpga_family",	LIBERTY_ATTRENUM_fpga_family) ;
("fpga_complex_degenerate",	LIBERTY_ATTRENUM_fpga_complex_degenerate) ;
("fpga_cell_type",	LIBERTY_ATTRENUM_fpga_cell_type) ;
("fpga_bridge_inputs",	LIBERTY_ATTRENUM_fpga_bridge_inputs) ;
("fpga_prefer_undegenerated_gates",	LIBERTY_ATTRENUM_fpga_prefer_undegenerated_gates) ;
("fpga_allow_duplicate_degenerated_gates",	LIBERTY_ATTRENUM_fpga_allow_duplicate_degenerated_gates) ;
("force_inverter_removal",	LIBERTY_ATTRENUM_force_inverter_removal) ;
("fanout_resistance",	LIBERTY_ATTRENUM_fanout_resistance) ;
("fanout_capacitance",	LIBERTY_ATTRENUM_fanout_capacitance) ;
("fanout_area",	LIBERTY_ATTRENUM_fanout_area) ;
("wire_load_from_area",	LIBERTY_ATTRENUM_wire_load_from_area) ;
("fanout_length",	LIBERTY_ATTRENUM_fanout_length) ;
("slope",	LIBERTY_ATTRENUM_slope) ;
("resistance",	LIBERTY_ATTRENUM_resistance) ;
("slower_factor",	LIBERTY_ATTRENUM_slower_factor) ;
("faster_factor",	LIBERTY_ATTRENUM_faster_factor) ;
("default_power_rail",	LIBERTY_ATTRENUM_default_power_rail) ;
("vomin",	LIBERTY_ATTRENUM_vomin) ;
("vomax",	LIBERTY_ATTRENUM_vomax) ;
("vol",	LIBERTY_ATTRENUM_vol) ;
("voh",	LIBERTY_ATTRENUM_voh) ;
("driver_waveform_name",	LIBERTY_ATTRENUM_driver_waveform_name) ;
("power_rail",	LIBERTY_ATTRENUM_power_rail) ;
("voltage",	LIBERTY_ATTRENUM_voltage) ;
("tree_type",	LIBERTY_ATTRENUM_tree_type) ;
("temperature",	LIBERTY_ATTRENUM_temperature) ;
("parameter5",	LIBERTY_ATTRENUM_parameter5) ;
("parameter4",	LIBERTY_ATTRENUM_parameter4) ;
("parameter3",	LIBERTY_ATTRENUM_parameter3) ;
("parameter2",	LIBERTY_ATTRENUM_parameter2) ;
("parameter1",	LIBERTY_ATTRENUM_parameter1) ;
("short",	LIBERTY_ATTRENUM_short) ;
("cell_name",	LIBERTY_ATTRENUM_cell_name) ;
("variable_4",	LIBERTY_ATTRENUM_variable_4) ;
("base_curves_group",	LIBERTY_ATTRENUM_base_curves_group) ;
("vector",	LIBERTY_ATTRENUM_vector) ;
("pin_names",	LIBERTY_ATTRENUM_pin_names) ;
("curve_y",	LIBERTY_ATTRENUM_curve_y) ;
("curve_x",	LIBERTY_ATTRENUM_curve_x) ;
("curve_id",	LIBERTY_ATTRENUM_curve_id) ;
("base_curve_type",	LIBERTY_ATTRENUM_base_curve_type) ;
("vimin",	LIBERTY_ATTRENUM_vimin) ;
("vimax",	LIBERTY_ATTRENUM_vimax) ;
("vil",	LIBERTY_ATTRENUM_vil) ;
("vih",	LIBERTY_ATTRENUM_vih) ;
("downto",	LIBERTY_ATTRENUM_downto) ;
("data_type",	LIBERTY_ATTRENUM_data_type) ;
("bit_width",	LIBERTY_ATTRENUM_bit_width) ;
("bit_to",	LIBERTY_ATTRENUM_bit_to) ;
("bit_from",	LIBERTY_ATTRENUM_bit_from) ;
("base_type",	LIBERTY_ATTRENUM_base_type) ;
("table",	LIBERTY_ATTRENUM_table) ;
("force_11",	LIBERTY_ATTRENUM_force_11) ;
("force_10",	LIBERTY_ATTRENUM_force_10) ;
("force_01",	LIBERTY_ATTRENUM_force_01) ;
("force_00",	LIBERTY_ATTRENUM_force_00) ;
("tracks",	LIBERTY_ATTRENUM_tracks) ;
("total_track_area",	LIBERTY_ATTRENUM_total_track_area) ;
("word_width",	LIBERTY_ATTRENUM_word_width) ;
("type",	LIBERTY_ATTRENUM_type) ;
("row_address",	LIBERTY_ATTRENUM_row_address) ;
("column_address",	LIBERTY_ATTRENUM_column_address) ;
("address_width",	LIBERTY_ATTRENUM_address_width) ;
("input_high_value",	LIBERTY_ATTRENUM_input_high_value) ;
("input_low_value",	LIBERTY_ATTRENUM_input_low_value) ;
("related_output",	LIBERTY_ATTRENUM_related_output) ;
("index_output",	LIBERTY_ATTRENUM_index_output) ;
("output_switching_condition",	LIBERTY_ATTRENUM_output_switching_condition) ;
("input_switching_condition",	LIBERTY_ATTRENUM_input_switching_condition) ;
("typical_capacitances",	LIBERTY_ATTRENUM_typical_capacitances) ;
("value",	LIBERTY_ATTRENUM_value) ;
("enable_also",	LIBERTY_ATTRENUM_enable_also) ;
("data_in",	LIBERTY_ATTRENUM_data_in) ;
("shifts",	LIBERTY_ATTRENUM_shifts) ;
("edges",	LIBERTY_ATTRENUM_edges) ;
("multiplied_by",	LIBERTY_ATTRENUM_multiplied_by) ;
("master_pin",	LIBERTY_ATTRENUM_master_pin) ;
("invert",	LIBERTY_ATTRENUM_invert) ;
("duty_cycle",	LIBERTY_ATTRENUM_duty_cycle) ;
("divided_by",	LIBERTY_ATTRENUM_divided_by) ;
("clock_pin",	LIBERTY_ATTRENUM_clock_pin) ;
("preset",	LIBERTY_ATTRENUM_preset) ;
("next_state",	LIBERTY_ATTRENUM_next_state) ;
("clocked_on_also",	LIBERTY_ATTRENUM_clocked_on_also) ;
("clear_preset_var2",	LIBERTY_ATTRENUM_clear_preset_var2) ;
("clear_preset_var1",	LIBERTY_ATTRENUM_clear_preset_var1) ;
("clear",	LIBERTY_ATTRENUM_clear) ;
("bus_type",	LIBERTY_ATTRENUM_bus_type) ;
("tdisable",	LIBERTY_ATTRENUM_tdisable) ;
("edge_type",	LIBERTY_ATTRENUM_edge_type) ;
("va_values",	LIBERTY_ATTRENUM_va_values) ;
("nominal_va_values",	LIBERTY_ATTRENUM_nominal_va_values) ;
("reference_time",	LIBERTY_ATTRENUM_reference_time) ;
("rise_pin_resistance",	LIBERTY_ATTRENUM_rise_pin_resistance) ;
("rise_delay_intercept",	LIBERTY_ATTRENUM_rise_delay_intercept) ;
("mode",	LIBERTY_ATTRENUM_mode) ;
("fall_pin_resistance",	LIBERTY_ATTRENUM_fall_pin_resistance) ;
("fall_delay_intercept",	LIBERTY_ATTRENUM_fall_delay_intercept) ;
("wave_fall",	LIBERTY_ATTRENUM_wave_fall) ;
("wave_rise",	LIBERTY_ATTRENUM_wave_rise) ;
("when_start",	LIBERTY_ATTRENUM_when_start) ;
("when_end",	LIBERTY_ATTRENUM_when_end) ;
("timing_type",	LIBERTY_ATTRENUM_timing_type) ;
("timing_sense",	LIBERTY_ATTRENUM_timing_sense) ;
("tied_off",	LIBERTY_ATTRENUM_tied_off) ;
("steady_state_resistance_low_min",	LIBERTY_ATTRENUM_steady_state_resistance_low_min) ;
("steady_state_resistance_low_max",	LIBERTY_ATTRENUM_steady_state_resistance_low_max) ;
("steady_state_resistance_low",	LIBERTY_ATTRENUM_steady_state_resistance_low) ;
("steady_state_resistance_high_min",	LIBERTY_ATTRENUM_steady_state_resistance_high_min) ;
("steady_state_resistance_high_max",	LIBERTY_ATTRENUM_steady_state_resistance_high_max) ;
("steady_state_resistance_high",	LIBERTY_ATTRENUM_steady_state_resistance_high) ;
("steady_state_resistance_float_min",	LIBERTY_ATTRENUM_steady_state_resistance_float_min) ;
("steady_state_resistance_float_max",	LIBERTY_ATTRENUM_steady_state_resistance_float_max) ;
("steady_state_resistance_below_low",	LIBERTY_ATTRENUM_steady_state_resistance_below_low) ;
("steady_state_resistance_above_high",	LIBERTY_ATTRENUM_steady_state_resistance_above_high) ;
("slope_rise",	LIBERTY_ATTRENUM_slope_rise) ;
("slope_fall",	LIBERTY_ATTRENUM_slope_fall) ;
("setup_coefficient",	LIBERTY_ATTRENUM_setup_coefficient) ;
("sdf_edges",	LIBERTY_ATTRENUM_sdf_edges) ;
("sdf_cond_start",	LIBERTY_ATTRENUM_sdf_cond_start) ;
("sdf_cond_end",	LIBERTY_ATTRENUM_sdf_cond_end) ;
("rise_resistance",	LIBERTY_ATTRENUM_rise_resistance) ;
("related_output_pin",	LIBERTY_ATTRENUM_related_output_pin) ;
("related_bus_equivalent",	LIBERTY_ATTRENUM_related_bus_equivalent) ;
("intrinsic_rise",	LIBERTY_ATTRENUM_intrinsic_rise) ;
("intrinsic_fall",	LIBERTY_ATTRENUM_intrinsic_fall) ;
("interdependence_id",	LIBERTY_ATTRENUM_interdependence_id) ;
("hold_coefficient",	LIBERTY_ATTRENUM_hold_coefficient) ;
("fall_resistance",	LIBERTY_ATTRENUM_fall_resistance) ;
("edge_rate_sensitivity_r1",	LIBERTY_ATTRENUM_edge_rate_sensitivity_r1) ;
("edge_rate_sensitivity_r0",	LIBERTY_ATTRENUM_edge_rate_sensitivity_r0) ;
("edge_rate_sensitivity_f1",	LIBERTY_ATTRENUM_edge_rate_sensitivity_f1) ;
("edge_rate_sensitivity_f0",	LIBERTY_ATTRENUM_edge_rate_sensitivity_f0) ;
("default_timing",	LIBERTY_ATTRENUM_default_timing) ;
("clock_gating_flag",	LIBERTY_ATTRENUM_clock_gating_flag) ;
("index_4",	LIBERTY_ATTRENUM_index_4) ;
("miller_cap_fall",	LIBERTY_ATTRENUM_miller_cap_fall) ;
("miller_cap_rise",	LIBERTY_ATTRENUM_miller_cap_rise) ;
("is_inverting",	LIBERTY_ATTRENUM_is_inverting) ;
("stage_type",	LIBERTY_ATTRENUM_stage_type) ;
("is_needed",	LIBERTY_ATTRENUM_is_needed) ;
("high",	LIBERTY_ATTRENUM_high) ;
("low",	LIBERTY_ATTRENUM_low) ;
("rise_capacitance_range",	LIBERTY_ATTRENUM_rise_capacitance_range) ;
("retention_pin",	LIBERTY_ATTRENUM_retention_pin) ;
("fall_capacitance_range",	LIBERTY_ATTRENUM_fall_capacitance_range) ;
("input_signal_level_low",	LIBERTY_ATTRENUM_input_signal_level_low) ;
("input_signal_level_high",	LIBERTY_ATTRENUM_input_signal_level_high) ;
("switch_pin",	LIBERTY_ATTRENUM_switch_pin) ;
("related_ground_pin",	LIBERTY_ATTRENUM_related_ground_pin) ;
("related_power_pin",	LIBERTY_ATTRENUM_related_power_pin) ;
("power_down_function",	LIBERTY_ATTRENUM_power_down_function) ;
("lsi_pad",	LIBERTY_ATTRENUM_lsi_pad) ;
("fsim_map",	LIBERTY_ATTRENUM_fsim_map) ;
("constraint",	LIBERTY_ATTRENUM_constraint) ;
("sdf_cond",	LIBERTY_ATTRENUM_sdf_cond) ;
("constraint_low",	LIBERTY_ATTRENUM_constraint_low) ;
("constraint_high",	LIBERTY_ATTRENUM_constraint_high) ;
("enable",	LIBERTY_ATTRENUM_enable) ;
("clocked_on",	LIBERTY_ATTRENUM_clocked_on) ;
("address",	LIBERTY_ATTRENUM_address) ;
("switching_together_group",	LIBERTY_ATTRENUM_switching_together_group) ;
("switching_interval",	LIBERTY_ATTRENUM_switching_interval) ;
("rising_together_group",	LIBERTY_ATTRENUM_rising_together_group) ;
("related_rising_pin",	LIBERTY_ATTRENUM_related_rising_pin) ;
("related_outputs",	LIBERTY_ATTRENUM_related_outputs) ;
("related_inputs",	LIBERTY_ATTRENUM_related_inputs) ;
("related_input",	LIBERTY_ATTRENUM_related_input) ;
("related_falling_pin",	LIBERTY_ATTRENUM_related_falling_pin) ;
("power_level",	LIBERTY_ATTRENUM_power_level) ;
("falling_together_group",	LIBERTY_ATTRENUM_falling_together_group) ;
("equal_or_opposite_output",	LIBERTY_ATTRENUM_equal_or_opposite_output) ;
("width_coefficient",	LIBERTY_ATTRENUM_width_coefficient) ;
("height_coefficient",	LIBERTY_ATTRENUM_height_coefficient) ;
("area_coefficient",	LIBERTY_ATTRENUM_area_coefficient) ;
("variables",	LIBERTY_ATTRENUM_variables) ;
("mapping",	LIBERTY_ATTRENUM_mapping) ;
("variable_3",	LIBERTY_ATTRENUM_variable_3) ;
("variable_2",	LIBERTY_ATTRENUM_variable_2) ;
("variable_1",	LIBERTY_ATTRENUM_variable_1) ;
("calc_mode",	LIBERTY_ATTRENUM_calc_mode) ;
("variable_7_range",	LIBERTY_ATTRENUM_variable_7_range) ;
("variable_6_range",	LIBERTY_ATTRENUM_variable_6_range) ;
("variable_5_range",	LIBERTY_ATTRENUM_variable_5_range) ;
("variable_4_range",	LIBERTY_ATTRENUM_variable_4_range) ;
("variable_3_range",	LIBERTY_ATTRENUM_variable_3_range) ;
("variable_2_range",	LIBERTY_ATTRENUM_variable_2_range) ;
("variable_1_range",	LIBERTY_ATTRENUM_variable_1_range) ;
("orders",	LIBERTY_ATTRENUM_orders) ;
("intermediate_values",	LIBERTY_ATTRENUM_intermediate_values) ;
("index_3",	LIBERTY_ATTRENUM_index_3) ;
("coefs",	LIBERTY_ATTRENUM_coefs) ;
("threshold",	LIBERTY_ATTRENUM_threshold) ;
("process",	LIBERTY_ATTRENUM_process) ;
("poly_convert",	LIBERTY_ATTRENUM_poly_convert) ;
("when",	LIBERTY_ATTRENUM_when) ;
("related_pin",	LIBERTY_ATTRENUM_related_pin) ;
("related_bus_pins",	LIBERTY_ATTRENUM_related_bus_pins) ;
("power_gating_pin",	LIBERTY_ATTRENUM_power_gating_pin) ;
("members",	LIBERTY_ATTRENUM_members) ;
("input_map_shift",	LIBERTY_ATTRENUM_input_map_shift) ;
("x_function",	LIBERTY_ATTRENUM_x_function) ;
("three_state",	LIBERTY_ATTRENUM_three_state) ;
("test_output_only",	LIBERTY_ATTRENUM_test_output_only) ;
("state_function",	LIBERTY_ATTRENUM_state_function) ;
("slew_control",	LIBERTY_ATTRENUM_slew_control) ;
("signal_type",	LIBERTY_ATTRENUM_signal_type) ;
("rise_time_before_threshold",	LIBERTY_ATTRENUM_rise_time_before_threshold) ;
("rise_time_after_threshold",	LIBERTY_ATTRENUM_rise_time_after_threshold) ;
("rise_current_slope_before_threshold",	LIBERTY_ATTRENUM_rise_current_slope_before_threshold) ;
("rise_current_slope_after_threshold",	LIBERTY_ATTRENUM_rise_current_slope_after_threshold) ;
("rise_capacitance",	LIBERTY_ATTRENUM_rise_capacitance) ;
("reference_capacitance",	LIBERTY_ATTRENUM_reference_capacitance) ;
("pulling_resistance",	LIBERTY_ATTRENUM_pulling_resistance) ;
("pulling_current",	LIBERTY_ATTRENUM_pulling_current) ;
("primary_output",	LIBERTY_ATTRENUM_primary_output) ;
("prefer_tied",	LIBERTY_ATTRENUM_prefer_tied) ;
("pin_func_type",	LIBERTY_ATTRENUM_pin_func_type) ;
("output_voltage",	LIBERTY_ATTRENUM_output_voltage) ;
("output_signal_level_low",	LIBERTY_ATTRENUM_output_signal_level_low) ;
("output_signal_level_high",	LIBERTY_ATTRENUM_output_signal_level_high) ;
("output_signal_level",	LIBERTY_ATTRENUM_output_signal_level) ;
("nextstate_type",	LIBERTY_ATTRENUM_nextstate_type) ;
("multicell_pad_pin",	LIBERTY_ATTRENUM_multicell_pad_pin) ;
("min_transition",	LIBERTY_ATTRENUM_min_transition) ;
("min_pulse_width_low",	LIBERTY_ATTRENUM_min_pulse_width_low) ;
("min_pulse_width_high",	LIBERTY_ATTRENUM_min_pulse_width_high) ;
("min_period",	LIBERTY_ATTRENUM_min_period) ;
("min_input_noise_width",	LIBERTY_ATTRENUM_min_input_noise_width) ;
("min_fanout",	LIBERTY_ATTRENUM_min_fanout) ;
("min_capacitance",	LIBERTY_ATTRENUM_min_capacitance) ;
("max_transition",	LIBERTY_ATTRENUM_max_transition) ;
("max_time_borrow",	LIBERTY_ATTRENUM_max_time_borrow) ;
("max_input_noise_width",	LIBERTY_ATTRENUM_max_input_noise_width) ;
("max_fanout",	LIBERTY_ATTRENUM_max_fanout) ;
("max_capacitance",	LIBERTY_ATTRENUM_max_capacitance) ;
("map_to_logic",	LIBERTY_ATTRENUM_map_to_logic) ;
("level_shifter_enable_pin",	LIBERTY_ATTRENUM_level_shifter_enable_pin) ;
("level_shifter_data_pin",	LIBERTY_ATTRENUM_level_shifter_data_pin) ;
("isolation_cell_enable_pin",	LIBERTY_ATTRENUM_isolation_cell_enable_pin) ;
("isolation_cell_data_pin",	LIBERTY_ATTRENUM_isolation_cell_data_pin) ;
("is_three_state",	LIBERTY_ATTRENUM_is_three_state) ;
("is_pad",	LIBERTY_ATTRENUM_is_pad) ;
("inverted_output",	LIBERTY_ATTRENUM_inverted_output) ;
("internal_node",	LIBERTY_ATTRENUM_internal_node) ;
("input_voltage",	LIBERTY_ATTRENUM_input_voltage) ;
("input_signal_level",	LIBERTY_ATTRENUM_input_signal_level) ;
("input_map",	LIBERTY_ATTRENUM_input_map) ;
("hysteresis",	LIBERTY_ATTRENUM_hysteresis) ;
("has_builtin_pad",	LIBERTY_ATTRENUM_has_builtin_pad) ;
("function",	LIBERTY_ATTRENUM_function) ;
("fault_model",	LIBERTY_ATTRENUM_fault_model) ;
("fanout_load",	LIBERTY_ATTRENUM_fanout_load) ;
("fall_time_before_threshold",	LIBERTY_ATTRENUM_fall_time_before_threshold) ;
("fall_time_after_threshold",	LIBERTY_ATTRENUM_fall_time_after_threshold) ;
("fall_current_slope_before_threshold",	LIBERTY_ATTRENUM_fall_current_slope_before_threshold) ;
("fall_current_slope_after_threshold",	LIBERTY_ATTRENUM_fall_current_slope_after_threshold) ;
("fall_capacitance",	LIBERTY_ATTRENUM_fall_capacitance) ;
("edge_rate_rise",	LIBERTY_ATTRENUM_edge_rate_rise) ;
("edge_rate_load_rise",	LIBERTY_ATTRENUM_edge_rate_load_rise) ;
("edge_rate_load_fall",	LIBERTY_ATTRENUM_edge_rate_load_fall) ;
("edge_rate_fall",	LIBERTY_ATTRENUM_edge_rate_fall) ;
("edge_rate_breakpoint_r1",	LIBERTY_ATTRENUM_edge_rate_breakpoint_r1) ;
("edge_rate_breakpoint_r0",	LIBERTY_ATTRENUM_edge_rate_breakpoint_r0) ;
("edge_rate_breakpoint_f1",	LIBERTY_ATTRENUM_edge_rate_breakpoint_f1) ;
("edge_rate_breakpoint_f0",	LIBERTY_ATTRENUM_edge_rate_breakpoint_f0) ;
("driver_type",	LIBERTY_ATTRENUM_driver_type) ;
("drive_current",	LIBERTY_ATTRENUM_drive_current) ;
("dcm_timing",	LIBERTY_ATTRENUM_dcm_timing) ;
("connection_class",	LIBERTY_ATTRENUM_connection_class) ;
("complementary_pin",	LIBERTY_ATTRENUM_complementary_pin) ;
("clock_gate_test_pin",	LIBERTY_ATTRENUM_clock_gate_test_pin) ;
("clock_gate_out_pin",	LIBERTY_ATTRENUM_clock_gate_out_pin) ;
("clock_gate_obs_pin",	LIBERTY_ATTRENUM_clock_gate_obs_pin) ;
("clock_gate_enable_pin",	LIBERTY_ATTRENUM_clock_gate_enable_pin) ;
("clock_gate_clock_pin",	LIBERTY_ATTRENUM_clock_gate_clock_pin) ;
("clock",	LIBERTY_ATTRENUM_clock) ;
("capacitance",	LIBERTY_ATTRENUM_capacitance) ;
("values",	LIBERTY_ATTRENUM_values) ;
("index_2",	LIBERTY_ATTRENUM_index_2) ;
("index_1",	LIBERTY_ATTRENUM_index_1) ;
("related_internal_pg_pin",	LIBERTY_ATTRENUM_related_internal_pg_pin) ;
("related_pg_pin",	LIBERTY_ATTRENUM_related_pg_pin) ;
("related_switch_pin",	LIBERTY_ATTRENUM_related_switch_pin) ;
("direction",	LIBERTY_ATTRENUM_direction) ;
("pg_type",	LIBERTY_ATTRENUM_pg_type) ;
("std_cell_main_rail",	LIBERTY_ATTRENUM_std_cell_main_rail) ;
("voltage_name",	LIBERTY_ATTRENUM_voltage_name) ;
("pg_function",	LIBERTY_ATTRENUM_pg_function) ;
("switch_function",	LIBERTY_ATTRENUM_switch_function) ;
("rail_connection",	LIBERTY_ATTRENUM_rail_connection) ;
("pin_opposite",	LIBERTY_ATTRENUM_pin_opposite) ;
("pin_equal",	LIBERTY_ATTRENUM_pin_equal) ;
("output_voltage_range",	LIBERTY_ATTRENUM_output_voltage_range) ;
("input_voltage_range",	LIBERTY_ATTRENUM_input_voltage_range) ;
("pin_name_map",	LIBERTY_ATTRENUM_pin_name_map) ;
("driver_waveform_fall",	LIBERTY_ATTRENUM_driver_waveform_fall) ;
("driver_waveform_rise",	LIBERTY_ATTRENUM_driver_waveform_rise) ;
("driver_waveform",	LIBERTY_ATTRENUM_driver_waveform) ;
("sensitization_master",	LIBERTY_ATTRENUM_sensitization_master) ;
("vhdl_name",	LIBERTY_ATTRENUM_vhdl_name) ;
("user_function_class",	LIBERTY_ATTRENUM_user_function_class) ;
("use_for_size_only",	LIBERTY_ATTRENUM_use_for_size_only) ;
("timing_model_type",	LIBERTY_ATTRENUM_timing_model_type) ;
("threshold_voltage_group",	LIBERTY_ATTRENUM_threshold_voltage_group) ;
("switch_cell_type",	LIBERTY_ATTRENUM_switch_cell_type) ;
("single_bit_degenerate",	LIBERTY_ATTRENUM_single_bit_degenerate) ;
("set_node",	LIBERTY_ATTRENUM_set_node) ;
("scan_group",	LIBERTY_ATTRENUM_scan_group) ;
("scaling_factors",	LIBERTY_ATTRENUM_scaling_factors) ;
("retention_cell",	LIBERTY_ATTRENUM_retention_cell) ;
("preferred",	LIBERTY_ATTRENUM_preferred) ;
("power_gating_cell",	LIBERTY_ATTRENUM_power_gating_cell) ;
("pad_type",	LIBERTY_ATTRENUM_pad_type) ;
("pad_cell",	LIBERTY_ATTRENUM_pad_cell) ;
("observe_node",	LIBERTY_ATTRENUM_observe_node) ;
("mpm_name",	LIBERTY_ATTRENUM_mpm_name) ;
("mpm_libname",	LIBERTY_ATTRENUM_mpm_libname) ;
("map_only",	LIBERTY_ATTRENUM_map_only) ;
("level_shifter_type",	LIBERTY_ATTRENUM_level_shifter_type) ;
("is_level_shifter",	LIBERTY_ATTRENUM_is_level_shifter) ;
("is_isolation_cell",	LIBERTY_ATTRENUM_is_isolation_cell) ;
("is_clock_gating_cell",	LIBERTY_ATTRENUM_is_clock_gating_cell) ;
("interface_timing",	LIBERTY_ATTRENUM_interface_timing) ;
("ignore_verify_icg_type",	LIBERTY_ATTRENUM_ignore_verify_icg_type) ;
("handle_negative_constraint",	LIBERTY_ATTRENUM_handle_negative_constraint) ;
("geometry_print",	LIBERTY_ATTRENUM_geometry_print) ;
("failure_rate",	LIBERTY_ATTRENUM_failure_rate) ;
("dont_use",	LIBERTY_ATTRENUM_dont_use) ;
("dont_touch",	LIBERTY_ATTRENUM_dont_touch) ;
("dont_fault",	LIBERTY_ATTRENUM_dont_fault) ;
("contention_condition",	LIBERTY_ATTRENUM_contention_condition) ;
("clock_gating_integrated_cell",	LIBERTY_ATTRENUM_clock_gating_integrated_cell) ;
("cell_leakage_power",	LIBERTY_ATTRENUM_cell_leakage_power) ;
("cell_footprint",	LIBERTY_ATTRENUM_cell_footprint) ;
("auxiliary_pad_cell",	LIBERTY_ATTRENUM_auxiliary_pad_cell) ;
("area",	LIBERTY_ATTRENUM_area) ;
("voltage_map",	LIBERTY_ATTRENUM_voltage_map) ;
("va_parameters",	LIBERTY_ATTRENUM_va_parameters) ;
("technology",	LIBERTY_ATTRENUM_technology) ;
("routing_layers",	LIBERTY_ATTRENUM_routing_layers) ;
("piece_define",	LIBERTY_ATTRENUM_piece_define) ;
("library_features",	LIBERTY_ATTRENUM_library_features) ;
("define_cell_area",	LIBERTY_ATTRENUM_define_cell_area) ;
("capacitive_load_unit",	LIBERTY_ATTRENUM_capacitive_load_unit) ;
("voltage_unit",	LIBERTY_ATTRENUM_voltage_unit) ;
("timing_report",	LIBERTY_ATTRENUM_timing_report) ;
("time_unit",	LIBERTY_ATTRENUM_time_unit) ;
("slew_upper_threshold_pct_rise",	LIBERTY_ATTRENUM_slew_upper_threshold_pct_rise) ;
("slew_upper_threshold_pct_fall",	LIBERTY_ATTRENUM_slew_upper_threshold_pct_fall) ;
("slew_lower_threshold_pct_rise",	LIBERTY_ATTRENUM_slew_lower_threshold_pct_rise) ;
("slew_lower_threshold_pct_fall",	LIBERTY_ATTRENUM_slew_lower_threshold_pct_fall) ;
("slew_derate_from_library",	LIBERTY_ATTRENUM_slew_derate_from_library) ;
("simulation",	LIBERTY_ATTRENUM_simulation) ;
("revision",	LIBERTY_ATTRENUM_revision) ;
("resistance_unit",	LIBERTY_ATTRENUM_resistance_unit) ;
("pulling_resistance_unit",	LIBERTY_ATTRENUM_pulling_resistance_unit) ;
("preferred_output_pad_voltage",	LIBERTY_ATTRENUM_preferred_output_pad_voltage) ;
("preferred_output_pad_slew_rate_control",	LIBERTY_ATTRENUM_preferred_output_pad_slew_rate_control) ;
("preferred_input_pad_voltage",	LIBERTY_ATTRENUM_preferred_input_pad_voltage) ;
("power_model",	LIBERTY_ATTRENUM_power_model) ;
("piece_type",	LIBERTY_ATTRENUM_piece_type) ;
("output_threshold_pct_rise",	LIBERTY_ATTRENUM_output_threshold_pct_rise) ;
("output_threshold_pct_fall",	LIBERTY_ATTRENUM_output_threshold_pct_fall) ;
("nom_voltage",	LIBERTY_ATTRENUM_nom_voltage) ;
("nom_temperature",	LIBERTY_ATTRENUM_nom_temperature) ;
("nom_process",	LIBERTY_ATTRENUM_nom_process) ;
("nom_calc_mode",	LIBERTY_ATTRENUM_nom_calc_mode) ;
("lsi_rounding_digit",	LIBERTY_ATTRENUM_lsi_rounding_digit) ;
("lsi_rounding_cutoff",	LIBERTY_ATTRENUM_lsi_rounding_cutoff) ;
("lsi_pad_rise",	LIBERTY_ATTRENUM_lsi_pad_rise) ;
("lsi_pad_fall",	LIBERTY_ATTRENUM_lsi_pad_fall) ;
("leakage_power_unit",	LIBERTY_ATTRENUM_leakage_power_unit) ;
("key_version",	LIBERTY_ATTRENUM_key_version) ;
("key_seed",	LIBERTY_ATTRENUM_key_seed) ;
("key_file",	LIBERTY_ATTRENUM_key_file) ;
("key_feature",	LIBERTY_ATTRENUM_key_feature) ;
("key_bit",	LIBERTY_ATTRENUM_key_bit) ;
("k_volt_wire_res",	LIBERTY_ATTRENUM_k_volt_wire_res) ;
("k_volt_wire_cap",	LIBERTY_ATTRENUM_k_volt_wire_cap) ;
("k_volt_slope_rise",	LIBERTY_ATTRENUM_k_volt_slope_rise) ;
("k_volt_slope_fall",	LIBERTY_ATTRENUM_k_volt_slope_fall) ;
("k_volt_skew_rise",	LIBERTY_ATTRENUM_k_volt_skew_rise) ;
("k_volt_skew_fall",	LIBERTY_ATTRENUM_k_volt_skew_fall) ;
("k_volt_setup_rise",	LIBERTY_ATTRENUM_k_volt_setup_rise) ;
("k_volt_setup_fall",	LIBERTY_ATTRENUM_k_volt_setup_fall) ;
("k_volt_rise_transition",	LIBERTY_ATTRENUM_k_volt_rise_transition) ;
("k_volt_rise_propagation",	LIBERTY_ATTRENUM_k_volt_rise_propagation) ;
("k_volt_rise_pin_resistance",	LIBERTY_ATTRENUM_k_volt_rise_pin_resistance) ;
("k_volt_rise_delay_intercept",	LIBERTY_ATTRENUM_k_volt_rise_delay_intercept) ;
("k_volt_removal_rise",	LIBERTY_ATTRENUM_k_volt_removal_rise) ;
("k_volt_removal_fall",	LIBERTY_ATTRENUM_k_volt_removal_fall) ;
("k_volt_recovery_rise",	LIBERTY_ATTRENUM_k_volt_recovery_rise) ;
("k_volt_recovery_fall",	LIBERTY_ATTRENUM_k_volt_recovery_fall) ;
("k_volt_pin_cap",	LIBERTY_ATTRENUM_k_volt_pin_cap) ;
("k_volt_nochange_rise",	LIBERTY_ATTRENUM_k_volt_nochange_rise) ;
("k_volt_nochange_fall",	LIBERTY_ATTRENUM_k_volt_nochange_fall) ;
("k_volt_min_pulse_width_low",	LIBERTY_ATTRENUM_k_volt_min_pulse_width_low) ;
("k_volt_min_pulse_width_high",	LIBERTY_ATTRENUM_k_volt_min_pulse_width_high) ;
("k_volt_min_period",	LIBERTY_ATTRENUM_k_volt_min_period) ;
("k_volt_intrinsic_rise",	LIBERTY_ATTRENUM_k_volt_intrinsic_rise) ;
("k_volt_intrinsic_fall",	LIBERTY_ATTRENUM_k_volt_intrinsic_fall) ;
("k_volt_internal_power",	LIBERTY_ATTRENUM_k_volt_internal_power) ;
("k_volt_hold_rise",	LIBERTY_ATTRENUM_k_volt_hold_rise) ;
("k_volt_hold_fall",	LIBERTY_ATTRENUM_k_volt_hold_fall) ;
("k_volt_fall_transition",	LIBERTY_ATTRENUM_k_volt_fall_transition) ;
("k_volt_fall_propagation",	LIBERTY_ATTRENUM_k_volt_fall_propagation) ;
("k_volt_fall_pin_resistance",	LIBERTY_ATTRENUM_k_volt_fall_pin_resistance) ;
("k_volt_fall_delay_intercept",	LIBERTY_ATTRENUM_k_volt_fall_delay_intercept) ;
("k_volt_drive_rise",	LIBERTY_ATTRENUM_k_volt_drive_rise) ;
("k_volt_drive_fall",	LIBERTY_ATTRENUM_k_volt_drive_fall) ;
("k_volt_drive_current",	LIBERTY_ATTRENUM_k_volt_drive_current) ;
("k_volt_cell_rise",	LIBERTY_ATTRENUM_k_volt_cell_rise) ;
("k_volt_cell_leakage_power",	LIBERTY_ATTRENUM_k_volt_cell_leakage_power) ;
("k_volt_cell_fall",	LIBERTY_ATTRENUM_k_volt_cell_fall) ;
("k_volt_cell_degradation",	LIBERTY_ATTRENUM_k_volt_cell_degradation) ;
("k_temp_wire_res",	LIBERTY_ATTRENUM_k_temp_wire_res) ;
("k_temp_wire_cap",	LIBERTY_ATTRENUM_k_temp_wire_cap) ;
("k_temp_slope_rise",	LIBERTY_ATTRENUM_k_temp_slope_rise) ;
("k_temp_slope_fall",	LIBERTY_ATTRENUM_k_temp_slope_fall) ;
("k_temp_skew_rise",	LIBERTY_ATTRENUM_k_temp_skew_rise) ;
("k_temp_skew_fall",	LIBERTY_ATTRENUM_k_temp_skew_fall) ;
("k_temp_setup_rise",	LIBERTY_ATTRENUM_k_temp_setup_rise) ;
("k_temp_setup_fall",	LIBERTY_ATTRENUM_k_temp_setup_fall) ;
("k_temp_rise_transition",	LIBERTY_ATTRENUM_k_temp_rise_transition) ;
("k_temp_rise_propagation",	LIBERTY_ATTRENUM_k_temp_rise_propagation) ;
("k_temp_rise_pin_resistance",	LIBERTY_ATTRENUM_k_temp_rise_pin_resistance) ;
("k_temp_rise_delay_intercept",	LIBERTY_ATTRENUM_k_temp_rise_delay_intercept) ;
("k_temp_removal_rise",	LIBERTY_ATTRENUM_k_temp_removal_rise) ;
("k_temp_removal_fall",	LIBERTY_ATTRENUM_k_temp_removal_fall) ;
("k_temp_recovery_rise",	LIBERTY_ATTRENUM_k_temp_recovery_rise) ;
("k_temp_recovery_fall",	LIBERTY_ATTRENUM_k_temp_recovery_fall) ;
("k_temp_pin_cap",	LIBERTY_ATTRENUM_k_temp_pin_cap) ;
("k_temp_nochange_rise",	LIBERTY_ATTRENUM_k_temp_nochange_rise) ;
("k_temp_nochange_fall",	LIBERTY_ATTRENUM_k_temp_nochange_fall) ;
("k_temp_min_pulse_width_low",	LIBERTY_ATTRENUM_k_temp_min_pulse_width_low) ;
("k_temp_min_pulse_width_high",	LIBERTY_ATTRENUM_k_temp_min_pulse_width_high) ;
("k_temp_min_period",	LIBERTY_ATTRENUM_k_temp_min_period) ;
("k_temp_intrinsic_rise",	LIBERTY_ATTRENUM_k_temp_intrinsic_rise) ;
("k_temp_intrinsic_fall",	LIBERTY_ATTRENUM_k_temp_intrinsic_fall) ;
("k_temp_internal_power",	LIBERTY_ATTRENUM_k_temp_internal_power) ;
("k_temp_hold_rise",	LIBERTY_ATTRENUM_k_temp_hold_rise) ;
("k_temp_hold_fall",	LIBERTY_ATTRENUM_k_temp_hold_fall) ;
("k_temp_fall_transition",	LIBERTY_ATTRENUM_k_temp_fall_transition) ;
("k_temp_fall_propagation",	LIBERTY_ATTRENUM_k_temp_fall_propagation) ;
("k_temp_fall_pin_resistance",	LIBERTY_ATTRENUM_k_temp_fall_pin_resistance) ;
("k_temp_fall_delay_intercept",	LIBERTY_ATTRENUM_k_temp_fall_delay_intercept) ;
("k_temp_drive_rise",	LIBERTY_ATTRENUM_k_temp_drive_rise) ;
("k_temp_drive_fall",	LIBERTY_ATTRENUM_k_temp_drive_fall) ;
("k_temp_drive_current",	LIBERTY_ATTRENUM_k_temp_drive_current) ;
("k_temp_cell_rise",	LIBERTY_ATTRENUM_k_temp_cell_rise) ;
("k_temp_cell_leakage_power",	LIBERTY_ATTRENUM_k_temp_cell_leakage_power) ;
("k_temp_cell_fall",	LIBERTY_ATTRENUM_k_temp_cell_fall) ;
("k_temp_cell_degradation",	LIBERTY_ATTRENUM_k_temp_cell_degradation) ;
("k_process_wire_res",	LIBERTY_ATTRENUM_k_process_wire_res) ;
("k_process_wire_cap",	LIBERTY_ATTRENUM_k_process_wire_cap) ;
("k_process_slope_rise",	LIBERTY_ATTRENUM_k_process_slope_rise) ;
("k_process_slope_fall",	LIBERTY_ATTRENUM_k_process_slope_fall) ;
("k_process_skew_rise",	LIBERTY_ATTRENUM_k_process_skew_rise) ;
("k_process_skew_fall",	LIBERTY_ATTRENUM_k_process_skew_fall) ;
("k_process_setup_rise",	LIBERTY_ATTRENUM_k_process_setup_rise) ;
("k_process_setup_fall",	LIBERTY_ATTRENUM_k_process_setup_fall) ;
("k_process_rise_transition",	LIBERTY_ATTRENUM_k_process_rise_transition) ;
("k_process_rise_propagation",	LIBERTY_ATTRENUM_k_process_rise_propagation) ;
("k_process_rise_pin_resistance",	LIBERTY_ATTRENUM_k_process_rise_pin_resistance) ;
("k_process_rise_delay_intercept",	LIBERTY_ATTRENUM_k_process_rise_delay_intercept) ;
("k_process_removal_rise",	LIBERTY_ATTRENUM_k_process_removal_rise) ;
("k_process_removal_fall",	LIBERTY_ATTRENUM_k_process_removal_fall) ;
("k_process_recovery_rise",	LIBERTY_ATTRENUM_k_process_recovery_rise) ;
("k_process_recovery_fall",	LIBERTY_ATTRENUM_k_process_recovery_fall) ;
("k_process_pin_rise_cap",	LIBERTY_ATTRENUM_k_process_pin_rise_cap) ;
("k_process_pin_fall_cap",	LIBERTY_ATTRENUM_k_process_pin_fall_cap) ;
("k_process_pin_cap",	LIBERTY_ATTRENUM_k_process_pin_cap) ;
("k_process_nochange_rise",	LIBERTY_ATTRENUM_k_process_nochange_rise) ;
("k_process_nochange_fall",	LIBERTY_ATTRENUM_k_process_nochange_fall) ;
("k_process_min_pulse_width_low",	LIBERTY_ATTRENUM_k_process_min_pulse_width_low) ;
("k_process_min_pulse_width_high",	LIBERTY_ATTRENUM_k_process_min_pulse_width_high) ;
("k_process_min_period",	LIBERTY_ATTRENUM_k_process_min_period) ;
("k_process_intrinsic_rise",	LIBERTY_ATTRENUM_k_process_intrinsic_rise) ;
("k_process_intrinsic_fall",	LIBERTY_ATTRENUM_k_process_intrinsic_fall) ;
("k_process_internal_power",	LIBERTY_ATTRENUM_k_process_internal_power) ;
("k_process_hold_rise",	LIBERTY_ATTRENUM_k_process_hold_rise) ;
("k_process_hold_fall",	LIBERTY_ATTRENUM_k_process_hold_fall) ;
("k_process_fall_transition",	LIBERTY_ATTRENUM_k_process_fall_transition) ;
("k_process_fall_propagation",	LIBERTY_ATTRENUM_k_process_fall_propagation) ;
("k_process_fall_pin_resistance",	LIBERTY_ATTRENUM_k_process_fall_pin_resistance) ;
("k_process_fall_delay_intercept",	LIBERTY_ATTRENUM_k_process_fall_delay_intercept) ;
("k_process_drive_rise",	LIBERTY_ATTRENUM_k_process_drive_rise) ;
("k_process_drive_fall",	LIBERTY_ATTRENUM_k_process_drive_fall) ;
("k_process_drive_current",	LIBERTY_ATTRENUM_k_process_drive_current) ;
("k_process_cell_rise",	LIBERTY_ATTRENUM_k_process_cell_rise) ;
("k_process_cell_leakage_power",	LIBERTY_ATTRENUM_k_process_cell_leakage_power) ;
("k_process_cell_fall",	LIBERTY_ATTRENUM_k_process_cell_fall) ;
("k_process_cell_degradation",	LIBERTY_ATTRENUM_k_process_cell_degradation) ;
("input_threshold_pct_rise",	LIBERTY_ATTRENUM_input_threshold_pct_rise) ;
("input_threshold_pct_fall",	LIBERTY_ATTRENUM_input_threshold_pct_fall) ;
("in_place_swap_mode",	LIBERTY_ATTRENUM_in_place_swap_mode) ;
("em_temp_degradation_factor",	LIBERTY_ATTRENUM_em_temp_degradation_factor) ;
("delay_model",	LIBERTY_ATTRENUM_delay_model) ;
("default_wire_load_selection",	LIBERTY_ATTRENUM_default_wire_load_selection) ;
("default_wire_load_resistance",	LIBERTY_ATTRENUM_default_wire_load_resistance) ;
("default_wire_load_mode",	LIBERTY_ATTRENUM_default_wire_load_mode) ;
("default_wire_load_capacitance",	LIBERTY_ATTRENUM_default_wire_load_capacitance) ;
("default_wire_load_area",	LIBERTY_ATTRENUM_default_wire_load_area) ;
("default_wire_load",	LIBERTY_ATTRENUM_default_wire_load) ;
("default_threshold_voltage_group",	LIBERTY_ATTRENUM_default_threshold_voltage_group) ;
("default_slope_rise",	LIBERTY_ATTRENUM_default_slope_rise) ;
("default_slope_fall",	LIBERTY_ATTRENUM_default_slope_fall) ;
("default_setup_coefficient",	LIBERTY_ATTRENUM_default_setup_coefficient) ;
("default_rise_pin_resistance",	LIBERTY_ATTRENUM_default_rise_pin_resistance) ;
("default_rise_delay_intercept",	LIBERTY_ATTRENUM_default_rise_delay_intercept) ;
("default_reference_capacitance",	LIBERTY_ATTRENUM_default_reference_capacitance) ;
("default_rc_rise_coefficient",	LIBERTY_ATTRENUM_default_rc_rise_coefficient) ;
("default_rc_fall_coefficient",	LIBERTY_ATTRENUM_default_rc_fall_coefficient) ;
("default_output_pin_rise_res",	LIBERTY_ATTRENUM_default_output_pin_rise_res) ;
("default_output_pin_fall_res",	LIBERTY_ATTRENUM_default_output_pin_fall_res) ;
("default_output_pin_cap",	LIBERTY_ATTRENUM_default_output_pin_cap) ;
("default_operating_conditions",	LIBERTY_ATTRENUM_default_operating_conditions) ;
("default_min_porosity",	LIBERTY_ATTRENUM_default_min_porosity) ;
("default_max_utilization",	LIBERTY_ATTRENUM_default_max_utilization) ;
("default_max_transition",	LIBERTY_ATTRENUM_default_max_transition) ;
("default_max_fanout",	LIBERTY_ATTRENUM_default_max_fanout) ;
("default_max_capacitance",	LIBERTY_ATTRENUM_default_max_capacitance) ;
("default_leakage_power_density",	LIBERTY_ATTRENUM_default_leakage_power_density) ;
("default_intrinsic_rise",	LIBERTY_ATTRENUM_default_intrinsic_rise) ;
("default_intrinsic_fall",	LIBERTY_ATTRENUM_default_intrinsic_fall) ;
("default_input_pin_cap",	LIBERTY_ATTRENUM_default_input_pin_cap) ;
("default_inout_pin_rise_res",	LIBERTY_ATTRENUM_default_inout_pin_rise_res) ;
("default_inout_pin_fall_res",	LIBERTY_ATTRENUM_default_inout_pin_fall_res) ;
("default_inout_pin_cap",	LIBERTY_ATTRENUM_default_inout_pin_cap) ;
("default_hold_coefficient",	LIBERTY_ATTRENUM_default_hold_coefficient) ;
("default_fanout_load",	LIBERTY_ATTRENUM_default_fanout_load) ;
("default_fall_pin_resistance",	LIBERTY_ATTRENUM_default_fall_pin_resistance) ;
("default_fall_delay_intercept",	LIBERTY_ATTRENUM_default_fall_delay_intercept) ;
("default_edge_rate_breakpoint_r1",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_r1) ;
("default_edge_rate_breakpoint_r0",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_r0) ;
("default_edge_rate_breakpoint_f1",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_f1) ;
("default_edge_rate_breakpoint_f0",	LIBERTY_ATTRENUM_default_edge_rate_breakpoint_f0) ;
("default_connection_class",	LIBERTY_ATTRENUM_default_connection_class) ;
("default_cell_leakage_power",	LIBERTY_ATTRENUM_default_cell_leakage_power) ;
("default_cell_failure_rate",	LIBERTY_ATTRENUM_default_cell_failure_rate) ;
("date",	LIBERTY_ATTRENUM_date) ;
("current_unit",	LIBERTY_ATTRENUM_current_unit) ;
("comment",	LIBERTY_ATTRENUM_comment) ;
("bus_naming_style",	LIBERTY_ATTRENUM_bus_naming_style) ;
("lut",	LIBERTY_GROUPENUM_lut) ;
("wire_load_table",	LIBERTY_GROUPENUM_wire_load_table) ;
("wire_load_selection",	LIBERTY_GROUPENUM_wire_load_selection) ;
("interconnect_delay",	LIBERTY_GROUPENUM_interconnect_delay) ;
("wire_load",	LIBERTY_GROUPENUM_wire_load) ;
("user_parameters",	LIBERTY_GROUPENUM_user_parameters) ;
("timing_range",	LIBERTY_GROUPENUM_timing_range) ;
("scaling_factors",	LIBERTY_GROUPENUM_scaling_factors) ;
("scaled_cell",	LIBERTY_GROUPENUM_scaled_cell) ;
("rise_transition_degradation",	LIBERTY_GROUPENUM_rise_transition_degradation) ;
("rise_net_delay",	LIBERTY_GROUPENUM_rise_net_delay) ;
("propagation_lut_template",	LIBERTY_GROUPENUM_propagation_lut_template) ;
("power_supply",	LIBERTY_GROUPENUM_power_supply) ;
("power_poly_template",	LIBERTY_GROUPENUM_power_poly_template) ;
("power_lut_template",	LIBERTY_GROUPENUM_power_lut_template) ;
("poly_template",	LIBERTY_GROUPENUM_poly_template) ;
("output_voltage",	LIBERTY_GROUPENUM_output_voltage) ;
("ccs_lu_table_template",	LIBERTY_GROUPENUM_ccs_lu_table_template) ;
("pg_current_template",	LIBERTY_GROUPENUM_pg_current_template) ;
("output_current_template",	LIBERTY_GROUPENUM_output_current_template) ;
("normalized_driver_waveform",	LIBERTY_GROUPENUM_normalized_driver_waveform) ;
("operating_conditions",	LIBERTY_GROUPENUM_operating_conditions) ;
("noise_lut_template",	LIBERTY_GROUPENUM_noise_lut_template) ;
("model",	LIBERTY_GROUPENUM_model) ;
("maxtrans_lut_template",	LIBERTY_GROUPENUM_maxtrans_lut_template) ;
("maxcap_lut_template",	LIBERTY_GROUPENUM_maxcap_lut_template) ;
("lu_table_template",	LIBERTY_GROUPENUM_lu_table_template) ;
("compact_lut_template",	LIBERTY_GROUPENUM_compact_lut_template) ;
("sensitization",	LIBERTY_GROUPENUM_sensitization) ;
("base_curves",	LIBERTY_GROUPENUM_base_curves) ;
("ccs_timing_base_curve",	LIBERTY_GROUPENUM_ccs_timing_base_curve) ;
("ccs_timing_base_curve_template",	LIBERTY_GROUPENUM_ccs_timing_base_curve_template) ;
("iv_lut_template",	LIBERTY_GROUPENUM_iv_lut_template) ;
("input_voltage",	LIBERTY_GROUPENUM_input_voltage) ;
("fall_transition_degradation",	LIBERTY_GROUPENUM_fall_transition_degradation) ;
("fall_net_delay",	LIBERTY_GROUPENUM_fall_net_delay) ;
("em_lut_template",	LIBERTY_GROUPENUM_em_lut_template) ;
("type",	LIBERTY_GROUPENUM_type) ;
("test_cell",	LIBERTY_GROUPENUM_test_cell) ;
("statetable",	LIBERTY_GROUPENUM_statetable) ;
("state",	LIBERTY_GROUPENUM_state) ;
("seq_bank",	LIBERTY_GROUPENUM_seq_bank) ;
("seq",	LIBERTY_GROUPENUM_seq) ;
("routing_track",	LIBERTY_GROUPENUM_routing_track) ;
("mode_value",	LIBERTY_GROUPENUM_mode_value) ;
("mode_definition",	LIBERTY_GROUPENUM_mode_definition) ;
("memory",	LIBERTY_GROUPENUM_memory) ;
("gate_leakage",	LIBERTY_GROUPENUM_gate_leakage) ;
("leakage_current",	LIBERTY_GROUPENUM_leakage_current) ;
("intrinsic_capacitance",	LIBERTY_GROUPENUM_intrinsic_capacitance) ;
("intrinsic_resistance",	LIBERTY_GROUPENUM_intrinsic_resistance) ;
("intrinsic_parasitic",	LIBERTY_GROUPENUM_intrinsic_parasitic) ;
("pg_current",	LIBERTY_GROUPENUM_pg_current) ;
("switching_group",	LIBERTY_GROUPENUM_switching_group) ;
("dynamic_current",	LIBERTY_GROUPENUM_dynamic_current) ;
("leakage_power",	LIBERTY_GROUPENUM_leakage_power) ;
("latch_bank",	LIBERTY_GROUPENUM_latch_bank) ;
("latch",	LIBERTY_GROUPENUM_latch) ;
("generated_clock",	LIBERTY_GROUPENUM_generated_clock) ;
("ff_bank",	LIBERTY_GROUPENUM_ff_bank) ;
("ff",	LIBERTY_GROUPENUM_ff) ;
("bus",	LIBERTY_GROUPENUM_bus) ;
("pin_based_variation",	LIBERTY_GROUPENUM_pin_based_variation) ;
("tlatch",	LIBERTY_GROUPENUM_tlatch) ;
("va_fall_constraint",	LIBERTY_GROUPENUM_va_fall_constraint) ;
("va_rise_constraint",	LIBERTY_GROUPENUM_va_rise_constraint) ;
("va_receiver_capacitance2_rise",	LIBERTY_GROUPENUM_va_receiver_capacitance2_rise) ;
("va_receiver_capacitance2_fall",	LIBERTY_GROUPENUM_va_receiver_capacitance2_fall) ;
("va_receiver_capacitance1_rise",	LIBERTY_GROUPENUM_va_receiver_capacitance1_rise) ;
("va_receiver_capacitance1_fall",	LIBERTY_GROUPENUM_va_receiver_capacitance1_fall) ;
("va_compact_ccs_fall",	LIBERTY_GROUPENUM_va_compact_ccs_fall) ;
("va_compact_ccs_rise",	LIBERTY_GROUPENUM_va_compact_ccs_rise) ;
("timing_based_variation",	LIBERTY_GROUPENUM_timing_based_variation) ;
("steady_state_current_tristate",	LIBERTY_GROUPENUM_steady_state_current_tristate) ;
("steady_state_current_low",	LIBERTY_GROUPENUM_steady_state_current_low) ;
("steady_state_current_high",	LIBERTY_GROUPENUM_steady_state_current_high) ;
("rise_transition",	LIBERTY_GROUPENUM_rise_transition) ;
("rise_propagation",	LIBERTY_GROUPENUM_rise_propagation) ;
("rise_constraint",	LIBERTY_GROUPENUM_rise_constraint) ;
("retaining_rise",	LIBERTY_GROUPENUM_retaining_rise) ;
("retaining_fall",	LIBERTY_GROUPENUM_retaining_fall) ;
("retain_rise_slew",	LIBERTY_GROUPENUM_retain_rise_slew) ;
("retain_fall_slew",	LIBERTY_GROUPENUM_retain_fall_slew) ;
("propagated_noise_width_low",	LIBERTY_GROUPENUM_propagated_noise_width_low) ;
("propagated_noise_width_high",	LIBERTY_GROUPENUM_propagated_noise_width_high) ;
("propagated_noise_width_below_low",	LIBERTY_GROUPENUM_propagated_noise_width_below_low) ;
("propagated_noise_width_above_high",	LIBERTY_GROUPENUM_propagated_noise_width_above_high) ;
("propagated_noise_peak_time_ratio_low",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_low) ;
("propagated_noise_peak_time_ratio_high",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_high) ;
("propagated_noise_peak_time_ratio_below_low",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_below_low) ;
("propagated_noise_peak_time_ratio_above_high",	LIBERTY_GROUPENUM_propagated_noise_peak_time_ratio_above_high) ;
("propagated_noise_height_low",	LIBERTY_GROUPENUM_propagated_noise_height_low) ;
("propagated_noise_height_high",	LIBERTY_GROUPENUM_propagated_noise_height_high) ;
("propagated_noise_height_below_low",	LIBERTY_GROUPENUM_propagated_noise_height_below_low) ;
("propagated_noise_height_above_high",	LIBERTY_GROUPENUM_propagated_noise_height_above_high) ;
("output_current_rise",	LIBERTY_GROUPENUM_output_current_rise) ;
("right_id",	LIBERTY_GROUPENUM_right_id) ;
("left_id",	LIBERTY_GROUPENUM_left_id) ;
("peak_time",	LIBERTY_GROUPENUM_peak_time) ;
("peak_voltage",	LIBERTY_GROUPENUM_peak_voltage) ;
("peak_current",	LIBERTY_GROUPENUM_peak_current) ;
("init_current",	LIBERTY_GROUPENUM_init_current) ;
("compressed_ccs_timing_rise",	LIBERTY_GROUPENUM_compressed_ccs_timing_rise) ;
("compact_ccs_fall",	LIBERTY_GROUPENUM_compact_ccs_fall) ;
("compact_ccs_rise",	LIBERTY_GROUPENUM_compact_ccs_rise) ;
("output_current_fall",	LIBERTY_GROUPENUM_output_current_fall) ;
("noise_immunity_low",	LIBERTY_GROUPENUM_noise_immunity_low) ;
("noise_immunity_high",	LIBERTY_GROUPENUM_noise_immunity_high) ;
("noise_immunity_below_low",	LIBERTY_GROUPENUM_noise_immunity_below_low) ;
("noise_immunity_above_high",	LIBERTY_GROUPENUM_noise_immunity_above_high) ;
("fall_transition",	LIBERTY_GROUPENUM_fall_transition) ;
("fall_propagation",	LIBERTY_GROUPENUM_fall_propagation) ;
("fall_constraint",	LIBERTY_GROUPENUM_fall_constraint) ;
("cell_rise_to_pct",	LIBERTY_GROUPENUM_cell_rise_to_pct) ;
("cell_rise",	LIBERTY_GROUPENUM_cell_rise) ;
("cell_fall_to_pct",	LIBERTY_GROUPENUM_cell_fall_to_pct) ;
("cell_fall",	LIBERTY_GROUPENUM_cell_fall) ;
("cell_degradation",	LIBERTY_GROUPENUM_cell_degradation) ;
("timing",	LIBERTY_GROUPENUM_timing) ;
("receiver_capacitance2_rise",	LIBERTY_GROUPENUM_receiver_capacitance2_rise) ;
("receiver_capacitance2_fall",	LIBERTY_GROUPENUM_receiver_capacitance2_fall) ;
("receiver_capacitance1_rise",	LIBERTY_GROUPENUM_receiver_capacitance1_rise) ;
("receiver_capacitance1_fall",	LIBERTY_GROUPENUM_receiver_capacitance1_fall) ;
("receiver_capacitance",	LIBERTY_GROUPENUM_receiver_capacitance) ;
("rise_capacitance_range",	LIBERTY_GROUPENUM_rise_capacitance_range) ;
("rise_capacitance",	LIBERTY_GROUPENUM_rise_capacitance) ;
("upper",	LIBERTY_GROUPENUM_upper) ;
("lower",	LIBERTY_GROUPENUM_lower) ;
("fall_capacitance_range",	LIBERTY_GROUPENUM_fall_capacitance_range) ;
("fall_capacitance",	LIBERTY_GROUPENUM_fall_capacitance) ;
("capacitance",	LIBERTY_GROUPENUM_capacitance) ;
("pin_capacitance",	LIBERTY_GROUPENUM_pin_capacitance) ;
("ccsn_last_stage",	LIBERTY_GROUPENUM_ccsn_last_stage) ;
("propagated_noise_high",	LIBERTY_GROUPENUM_propagated_noise_high) ;
("propagated_noise_low",	LIBERTY_GROUPENUM_propagated_noise_low) ;
("output_voltage_fall",	LIBERTY_GROUPENUM_output_voltage_fall) ;
("vector",	LIBERTY_GROUPENUM_vector) ;
("output_voltage_rise",	LIBERTY_GROUPENUM_output_voltage_rise) ;
("ccsn_first_stage",	LIBERTY_GROUPENUM_ccsn_first_stage) ;
("output_signal_swing",	LIBERTY_GROUPENUM_output_signal_swing) ;
("input_signal_swing",	LIBERTY_GROUPENUM_input_signal_swing) ;
("pin",	LIBERTY_GROUPENUM_pin) ;
("minimum_period",	LIBERTY_GROUPENUM_minimum_period) ;
("min_pulse_width",	LIBERTY_GROUPENUM_min_pulse_width) ;
("memory_write",	LIBERTY_GROUPENUM_memory_write) ;
("memory_read",	LIBERTY_GROUPENUM_memory_read) ;
("max_trans",	LIBERTY_GROUPENUM_max_trans) ;
("max_cap",	LIBERTY_GROUPENUM_max_cap) ;
("rise_power",	LIBERTY_GROUPENUM_rise_power) ;
("power",	LIBERTY_GROUPENUM_power) ;
("fall_power",	LIBERTY_GROUPENUM_fall_power) ;
("internal_power",	LIBERTY_GROUPENUM_internal_power) ;
("hyperbolic_noise_low",	LIBERTY_GROUPENUM_hyperbolic_noise_low) ;
("hyperbolic_noise_high",	LIBERTY_GROUPENUM_hyperbolic_noise_high) ;
("hyperbolic_noise_below_low",	LIBERTY_GROUPENUM_hyperbolic_noise_below_low) ;
("hyperbolic_noise_above_high",	LIBERTY_GROUPENUM_hyperbolic_noise_above_high) ;
("domain",	LIBERTY_GROUPENUM_domain) ;
("em_max_toggle_rate",	LIBERTY_GROUPENUM_em_max_toggle_rate) ;
("electromigration",	LIBERTY_GROUPENUM_electromigration) ;
("bundle",	LIBERTY_GROUPENUM_bundle) ;
("dc_current",	LIBERTY_GROUPENUM_dc_current) ;
("pg_pin",	LIBERTY_GROUPENUM_pg_pin) ;
("cell",	LIBERTY_GROUPENUM_cell) ;
("library",	LIBERTY_GROUPENUM_library);
*)
("float", KW_FLOAT);
("string", KW_STRING);
("enum", KW_ENUM);
("integer", KW_INTEGER);
("int", KW_INTEGER);
("short", KW_SHORT);
("or", KW_OR);
("and", KW_AND);
("boolean", KW_BOOLEAN);
("list", KW_LIST) ];;

}

let digit = ['0'-'9']
let state4 = ['0'-'1' 'x' 'z' '?' 'X' 'Z' 'b' 'B']
let ident = ['a'-'z' 'A'-'Z' '_']
let ident_num = ['a'-'z' 'A'-'Z' '_' '0'-'9' '$']
let anything_but_blank = [ '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_newline = [ '\r' '\t' ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_quote = [ ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]

rule token = parse
|  '\\'anything_but_blank+' ' as word {ID word }
| "/*"
    { comment (Lexing.lexeme_start lexbuf) lexbuf; token lexbuf }
| "(*"
    { comment2 (Lexing.lexeme_start lexbuf) lexbuf; token lexbuf }
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
| "$" ident ident_num* as word {
if Hashtbl.mem ksymbols word then hlog lexbuf (Hashtbl.find ksymbols word) else hlog lexbuf (ID word)
}
| digit+'.'digit* as floatnum { hlog lexbuf ( NUM ( float_of_string floatnum ) ) }
| digit*'\''['d' 'D']digit+ as dnum { hlog lexbuf (NUM ( float_of_string dnum) ) }
| '\"'anything_but_quote*'\"' as asciinum { hlog lexbuf (STRING asciinum ) }
| ident ident_num* as word {
if Hashtbl.mem ksymbols word then hlog lexbuf (Hashtbl.find ksymbols word) else hlog lexbuf (ID word)
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
