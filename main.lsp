vl-load-com
(defun c:outdoor()
  (setq acadObj (vlax-get-acad-object))
  (setq doc (vla-get-ActiveDocument acadObj))
  (setq modelSpace (vla-get-ModelSpace doc))
  (setq root_drive (getstring "Enter the Drive name where ''auto_edrc_s&t'' is stored in your pc  (EXAMPLE:- D for D drive"))

  (setq end_plate_dim (list 17.4648 0.9536)
	end_stopper_dim(list 9.9625 1.9071)
	wago_dim(list 17.4648 3.1436)
	dinrail_dim(list 8 7)
	template_width 408.3109
	sheet_spacing 100
	STATION (getstring "Enter STATION CCP FILE ( for example VAREDIYA_CCP ) "))
  (alert (strcat "please confirm your chosen station ccp file as   " STATION ".xlsx" ))
  )