
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name THINPAD -dir "D:/Study/THU/2016Autumn/CPU/THINPAD/planAhead_run_5" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/Study/THU/2016Autumn/CPU/THINPAD/Main.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/Study/THU/2016Autumn/CPU/THINPAD} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "Main.ucf" [current_fileset -constrset]
add_files [list {Main.ucf}] -fileset [get_property constrset [current_run]]
link_design
