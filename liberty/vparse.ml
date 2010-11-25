(******************************************************************************
*
*    DESCRIPTION: Verilog parser program
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
*******************************************************************************)

exception Error

open Setup
open Globals
open Liberty_parser

let hash1 key item = Globals.unhandled (stdout,Format.std_formatter) 26 item

let rec parse_library key enum item = Stack.push (28, item) stk; (match item with
| TRIPLE (HEAD, STRING "define",
   TLIST [STRING text1; LIBERTY_GROUPENUM_library; STRING text2]) -> ()
| TRIPLE
  (HEAD, STRING "define_group",
   TLIST [STRING text; LIBERTY_GROUPENUM_rise_transition|LIBERTY_GROUPENUM_fall_transition|LIBERTY_GROUPENUM_pin|LIBERTY_GROUPENUM_bus]) -> ()
| TRIPLE (HEAD, STRING "define",
   TLIST
    [(LIBERTY_ATTRENUM_values|LIBERTY_ATTRENUM_index_1); STRING str1; STRING str2]) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_sdf_edges, STRING edges) -> ()
| TRIPLE (SIMPLE, STRING str, NUM num) -> ()
| TRIPLE (SIMPLE, STRING "always_on", STRING str2) -> ()
| TRIPLE (SIMPLE, STRING "is_macro_cell", STRING str2) -> ()
| TRIPLE (SIMPLE, STRING "related_bias_pin", STRING pin) -> ()
| TRIPLE (SIMPLE, STRING "physical_connection", STRING device_layer) -> ()
| TRIPLE (SIMPLE, LIBERTY_ENUM_type, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_address, STRING bus) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_bus_type, STRING bus) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_map_only, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_switch_pin, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_switch_function, STRING func) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_pg_function, STRING func) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_interface_timing, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_pg_type, LIBERTY_GROUPENUM_internal_power) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_switch_cell_type, STRING kind) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_address_width, NUM wid) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_word_width, NUM wid) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_base_type, STRING "array") -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_data_type, STRING "bit") -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_bit_width, NUM bwid) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_bit_from, NUM bfrom) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_bit_to, NUM bto) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_downto, STRING bool) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_revision, NUM rev) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_simulation, STRING bool) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_connection_class, STRING kind) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_bus_naming_style, STRING "\"%s[%d]\"") -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_temperature, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_cell_rise, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_cell_fall, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_setup_rise, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_setup_fall, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_hold_rise, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_hold_fall, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_rise_transition, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_fall_transition, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_min_pulse_width_high, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_process_min_pulse_width_low, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_temp_min_pulse_width_high, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_temp_min_pulse_width_low, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_min_pulse_width_high, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_min_pulse_width_low, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_setup_rise, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_setup_fall, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_hold_rise, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_hold_fall, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_cell_rise, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_cell_fall, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_rise_transition, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_k_volt_fall_transition, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_min_pulse_width_low, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_min_pulse_width_high, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_slew_upper_threshold_pct_rise, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_slew_upper_threshold_pct_fall, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_is_inverting, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_is_needed, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_miller_cap_fall, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_miller_cap_rise, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_stage_type, STRING str1) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_value, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_value, DOUBLE (MINUS, NUM num)) -> ()
| TRIPLE ( HEAD, LIBERTY_ATTRENUM_fanout_length, TLIST lst) -> ()
| TRIPLE ( HEAD, LIBERTY_ATTRENUM_library_features, TLIST lst) -> ()
| TRIPLE ( HEAD, LIBERTY_ATTRENUM_voltage_map, TLIST lst) -> ()
| TRIPLE ( HEAD, LIBERTY_ENUM_fall_capacitance_range, TLIST lst) -> ()
| TRIPLE ( HEAD, LIBERTY_ENUM_rise_capacitance_range, TLIST lst) -> ()
| TRIPLE ( HEAD, LIBERTY_ATTRENUM_wire_load_from_area, TLIST lst) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_constraint_low, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_constraint_high, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_wire_load_from_area, NUM area) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_wire_load_from_area, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_in_place_swap_mode, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_input_threshold_pct_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_input_threshold_pct_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_internal_node, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_process_cell_leakage_power, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_process_internal_power, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_cell_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_cell_leakage_power, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_cell_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_fall_propagation, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_fall_transition, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_hold_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_hold_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_internal_power, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_rise_propagation, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_rise_transition, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_setup_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_temp_setup_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_cell_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_cell_leakage_power, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_cell_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_fall_propagation, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_fall_transition, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_hold_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_hold_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_internal_power, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_rise_propagation, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_rise_transition, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_setup_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_k_volt_setup_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_leakage_power_unit, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_max_capacitance, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_max_transition, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_next_state, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_nextstate_type, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_nom_process, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_nom_temperature, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_nom_voltage, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_output_threshold_pct_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_output_threshold_pct_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_pg_type, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_power_down_function, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_preset, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_process, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_pulling_resistance_unit, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_ground_pin, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_pg_pin, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_power_pin, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_pin, STRING pins) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_inputs, STRING pin) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_output, STRING pin) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_related_outputs, STRING pin) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_resistance, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_revision, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_sdf_cond, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_signal_type, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_slew_derate_from_library, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_slew_lower_threshold_pct_fall, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_slew_lower_threshold_pct_rise, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_slope, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_state_function, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_table, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_temperature, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_test_output_only, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_time_unit, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_timing_sense, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_timing_type, LIBERTY_ATTRENUM_clear) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_timing_type, LIBERTY_ATTRENUM_preset) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_timing_type, LIBERTY_GROUPENUM_min_pulse_width) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_timing_type, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_tree_type, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_user_function_class, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_voltage, NUM num) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_voltage_name, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_voltage_unit, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ATTRENUM_when, STRING str) -> ()
| TRIPLE ( SIMPLE, LIBERTY_ENUM_rise_capacitance, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clock_gate_clock_pin, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clock_gate_enable_pin, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clock_gate_out_pin, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clock_gate_test_pin, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clock_gating_integrated_cell, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_comment, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_current_unit, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_data_in, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_date, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_cell_leakage_power, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_cell_leakage_power, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_fanout_load, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_fanout_load, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_inout_pin_cap, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_input_pin_cap, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_leakage_power_density, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_max_fanout, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_max_transition, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_operating_conditions, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_output_pin_cap, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_wire_load_mode, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_default_wire_load_selection, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_delay_model, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_dont_touch, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_dont_use, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_driver_type, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_driver_waveform_fall, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_driver_waveform_name, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_driver_waveform_rise, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_enable, STRING str) -> ()
| TRIPLE (SIMPLE, LIBERTY_ENUM_fall_capacitance, NUM num) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_capacitive_load_unit, TLIST lst) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_cell_footprint, STRING foot) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clear, STRING cond) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clear_preset_var1, STRING var1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clock, STRING cond) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_clocked_on, STRING clk) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_area, NUM area) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_values, TLIST lst) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_input_switching_condition, TLIST [STRING risefall]) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_output_switching_condition, TLIST [STRING risefall]) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_variable_1, LIBERTY_ENUM_input_voltage) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_variable_2, LIBERTY_ENUM_output_voltage) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_variable_1, STRING total_output_net_capacitance) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_variable_2, STRING input_net_transition) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_variable_3, STRING time) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_variable_4, STRING time) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_input_high_value, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_input_low_value, NUM num) -> ()
| TRIPLE (SIMPLE, LIBERTY_ENUM_capacitance, NUM cap) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_direction, STRING port) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_fall_resistance, NUM fallres) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_function, STRING func) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_index_1, STRING str1) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_values, STRING str1) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_index_1, TLIST [NUM index1]) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_index_2, TLIST [NUM index2]) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_index_1, TLIST [STRING index1]) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_index_2, TLIST [STRING index2]) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_index_3, TLIST [STRING index3]) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_index_4, TLIST [STRING index4]) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_rise_resistance, NUM riseres) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_intrinsic_fall, NUM ifall) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_intrinsic_rise, NUM irise) -> ()
| TRIPLE (SIMPLE, LIBERTY_ATTRENUM_reference_time, NUM num) -> ()
| TRIPLE (HEAD, LIBERTY_ATTRENUM_technology, TLIST [STRING tech]) -> ()
| TRIPLE (SIMPLE, attrenum, value) -> hash1 attrenum item
| TRIPLE (HEAD, attrenum, TLIST [token1; token2]) -> hash1 attrenum item
| TRIPLE (HEAD, attrenum, TLIST lst) -> List.iter (fun item2 -> match item2 with
    | STRING str ->  hash1 attrenum item
    | NUM num ->  hash1 attrenum item
    | _ -> parse_library key attrenum item2) lst
| TRIPLE (GROUP, TRIPLE (HEAD, groupenum, TLIST [STRING str]), TLIST lst) -> List.iter (fun item -> parse_library str groupenum item) lst
| TRIPLE (GROUP, groupenum, TLIST lst) -> List.iter (fun item -> parse_library key groupenum item) lst
| _ -> Globals.unhandled (stdout,Format.std_formatter) 28 item);
ignore(Stack.pop stk)

let parse str = begin
  (   let trc_file = Globals.mygetenv "VCHK_TRACE_FILE" in
    if (!Globals.trace_file == Closed) && (trc_file <> "") then
      let fd = open_out trc_file in
          Globals.trace_file := Open (fd,Format.formatter_of_out_channel fd); );
  ( if (!Globals.logfile == Closed) then
      let fd = open_out Globals.tmpnam in
          Globals.logfile := Open (fd,Format.formatter_of_out_channel fd); );
  match !Globals.logfile with Open out_chan -> begin
  Printf.fprintf (fst out_chan) "Open %s\n" str;
  try
    let lexbuf = Lexing.from_channel (open_in str) in
    let looping = ref true in while !looping do
      let rslt = Liberty_parser.file Vlexer.token lexbuf in match rslt with
      | TRIPLE(GROUP,TRIPLE(HEAD, LIBERTY_GROUPENUM_library, TLIST [STRING key]), TLIST lst) ->
          Hashtbl.add libraries key lst;
          List.iter (fun item -> parse_library key LIBERTY_GROUPENUM_library item) lst
      | ENDOFFILE -> looping := false
      | _ -> Globals.unhandled (stdout,Format.std_formatter) 191 rslt
    done
  with Stack.Empty -> ()
    | Parsing.Parse_error
    | Error ->
    begin
    psuccess := false;
    Printf.fprintf stdout "Parse Error in %s\n" str;
    Printf.fprintf (fst out_chan) "Parse Error in %s\n" str;
    for i = 1 to hsiz do let idx = (hsiz-i+(!histcnt))mod hsiz in let item = !(history.(idx)) in
        Printf.fprintf (fst out_chan) "Backtrace %d : %s (%d-%d)\n"  i (str_token (item.tok)) item.strt item.stop;
    done;
    end;
  end
| Closed -> failwith (Printf.sprintf "Failed to open logfile %s" Globals.tmpnam)
end
;;
