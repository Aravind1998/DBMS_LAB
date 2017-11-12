delimiter //

create procedure FinalMarks()
	begin
		declare test1 int;
		declare test2 int;
		declare test3 int;
		declare usn varchar(10);
		declare subCode varchar(7);
		declare finalAvg int;
		declare cur cursor for select USN, Subject_Code, Test1, Test2, Test3 from IAMARKS;
		open cur;
		loop
			fetch cur into usn, subCode, test1, test2, test3;
			set finalAvg = ((test1 + test2 + test3) - least(test1, test2, test3)) / 2;
			update IAMARKS set FinalIA = finalAvg where USN = usn and Subject_Code = subCode;
		end loop;
		close cur;
	end;
//
