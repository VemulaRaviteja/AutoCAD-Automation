vl-load-com
(defun loaddialog(location / max_row start_row)
  (GetExcel (strcat root_drive ":\\auto_edrc_s&t\\Outdoor Automation\\Database\\excel\\" STATION ".xlsx") location "Z2")
  (GetExcel (strcat root_drive ":\\auto_edrc_s&t\\Outdoor Automation\\Database\\excel\\" STATION ".xlsx") location (strcat "Z" (getcell "Z2")))
  (setq max_row (- (atoi (getcell "Z2")) 2)
	start_row 2
	current_row 2
	unique_id 1)
  (setq fname (open (strcat root_drive ":\\auto_edrc_s&t\\Outdoor Automation\\Sourcecodes\\DCL\\ui_cableorder.dcl") "w"))
  (write-line "dialog1 :dialog { label = \" INPUT CABLE ORDER \" ; " fname)
  (setq split "false")
  (while (< unique_id 5)
    (if (= split "false") (setq current_row 2)) 
    
    (write-line ":boxed_row { " fname)
    (cond
      ((= unique_id 1) (write-line "label = \"INCOMING CABLES\";" fname) )
      ((= unique_id 2) (write-line "label = \"OUTGOING CABLES\";" fname) )
      ((= unique_id 3) (write-line "label = \"RUN-THROUGH CABLES & SPARE\";" fname) )
      ((= unique_id 4) (write-line "label = \"TAIL CABLES\";" fname) )
      ((= unique_id 5) (write-line "label = \"SPARE CABLE\";" fname) )
      )
    (setq  cable_count 0 split "false" column "I")
    (while (and (<= current_row max_row) (= split "false"))
    (setq id (getcell (strcat "E" (rtos current_row 2 0)))
	  column "I")
    (if (OR ( = (atoi id) unique_id) (and (= unique_id 3) (= id "5") ))
      (progn
	(write-line (strcat ":boxed_column { label = \"[" (rtos current_row 2 0) "]" "\";") fname)
	(write-line (strcat ":text { label = \"" (getcell (strcat "A" (rtos current_row 2 0))) "\";}") fname)
	(write-line (strcat ":text { label = \"" (getcell (strcat "B" (rtos current_row 2 0))) "\";}") fname)
	(while(/= (getcell (strcat column (rtos current_row 2 0))) "")
	  (write-line (strcat ":text { label = \" (" (getcell (strcat column (rtos current_row 2 0))) ")" "\";}") fname)
	  (setq column (chr (1+ (ascii column))))
	  )
	(write-line "}" fname)
	)
      )
      (setq cable_count (1+ cable_count))
      (setq current_row (+ 2 current_row))
      (if (> cable_count 11) (setq split "true"))
      )
    (write-line "}" fname)
    (if (= split "false")(setq unique_id (1+ unique_id)))
    )
  (write-line ":boxed_row { label = \"Cable order for respective din rails \"; " fname)
  
  (write-line ":column { " fname)
  (write-line "
    : edit_box {key = order_a; width = 25; label = \"Input Din-rail A cable order here :- \";}
    : button {label = \"A_COUNT\"; key = \"dinrail_a_count\";alignment = centered; width = 20; is_default = false;}
    : edit_box {key = count_a; width = 7; value = \"0\";}
    " fname)
  (write-line "}" fname)
  
  (write-line ":column { " fname)
  (write-line "
    : edit_box {key = order_b; width = 25;label = \"Input Din-rail B cable order here :- \";}
    : button {label = \"B_COUNT\"; key = \"dinrail_b_count\";alignment = centered; width = 20; is_default = false;}
    : edit_box {key = count_b; width = 7; value = \"0\";}
    " fname)
  (write-line "}" fname)
  
  (write-line ":column { " fname)
  (write-line "
    : edit_box {key = order_c; width = 25;label = \"Input Din-rail C cable order here :- \";}
    : button {label = \"C_COUNT\"; key = \"dinrail_c_count\";alignment = centered; width = 20; is_default = false;}
    : edit_box {key = count_c; width = 7; value = \"0\";}
    " fname)
  (write-line "}" fname)
  
  (write-line ":column { " fname)
  (write-line "
    : edit_box {key = order_d; width = 25;label = \"Input Din-rail D cable order here :- \";}
    : button {label = \"D_COUNT\"; key = \"dinrail_d_count\";alignment = centered; width = 20; is_default = false;}
    : edit_box {key = count_d; width = 7; value = \"0\";}
    " fname)
  (write-line "}" fname)
  
  (write-line "}" fname)
  (write-line ": button	
	{
	key = \"accept\";
	label = \"OK\";
	is_default = true;
	fixed_width = true;
	alignment = centered;
	}" fname)
  (write-line "}" fname)
  (close fname)
  (loaddcl)
  )

(defun loaddcl()
  (setq dcl_id (load_dialog (strcat root_drive ":\\auto_edrc_s&t\\Outdoor Automation\\Sourcecodes\\DCL\\ui_cableorder.dcl")))
     (if (not (new_dialog "dialog1" dcl_id))
	 (exit )
     )
  (action_tile "accept" "(done_dialog)")
  (start_dialog)
  (unload_dialog dcl_id)
  )
  