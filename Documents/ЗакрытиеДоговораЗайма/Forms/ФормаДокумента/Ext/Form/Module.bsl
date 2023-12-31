﻿
#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область ОбработчикиСобытий

#КонецОбласти 

#Область ОбрабочикиСобытийЭлементовФормы

#КонецОбласти 

#Область ОбработчикКомандФорм

&НаКлиенте
Процедура РассчитатьИтоговуюСуммуЗаймаИПроценты(Команда)
	
	ПолучитьДанныеРасчета();
	ВыполнитьРасчетСуммыЗаймаИПроцентов(); 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПолучитьДанныеРасчета()
	
	Результат = Документы.ДоговорЗайма.ПолучитьДанныеРасчета(Объект.ДокументОснование, Объект.ДатаЗакрытияДоговора);
	Объект.ДанныеРасчета.Загрузить(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьРасчетСуммыЗаймаИПроцентов()
	
	Объект.Сумма = Объект.ДанныеРасчета.Итог("Сумма");
	Объект.СуммаПроцента = РасчитатьПроцентыЗаймаНаСервере();
	
КонецПроцедуры

&НаСервере
Функция РасчитатьПроцентыЗаймаНаСервере()
	//считать год в 356 не очень корректно раз в 4 года
	
	Ставка = Объект.ДокументОснование.Процент; 
	Данные = Объект.ДанныеРасчета.Выгрузить();
	
	Для Каждого Стр Из Данные Цикл
		Стр.Сумма = Стр.Сумма * Ставка 
				* (1 + Цел(
				(НачалоДня(Объект.ДатаЗакрытияДоговора) - НачалоДня(Стр.Дата))/(60*60*24)
				))/365/100;	
	КонецЦикла;
	
	Возврат Данные.Итог("Сумма");
	
КонецФункции

#Область Инициализация

#КонецОбласти

#КонецОбласти
