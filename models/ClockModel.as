﻿package models {	import flash.events.EventDispatcher;	import flash.utils.Timer;	import flash.events.TimerEvent;	import flash.events.Event;		public class ClockModel extends EventDispatcher {				private var _date:Date;				private var _timer:Timer;		public function ClockModel() {			_date = new Date(2371, 5, 25, 12, 15);			_timer = new Timer(1000);			_timer.addEventListener(TimerEvent.TIMER, onTimer);			_timer.start();		}				private function onTimer(e:TimerEvent):void {			_date.setSeconds(_date.getSeconds() + 1)			dispatchEvent(new Event(Event.CHANGE));		}						public function get hours():uint {			return _date.getHours();		}				public function get minutes():uint {			return _date.getMinutes();		}				public function get seconds():uint {			return _date.getSeconds();		}				public function get day():uint {			return _date.getDate();		}				public function get month():uint {			return _date.getMonth();		}				public function get year():uint {			return _date.getFullYear();		}				//the stardate is calculated by the current year, day of year, hour and minute based on how many stardate units have		//passed since 29.06.1956 (found by decrementing the first stardate given by the right amount of stardate units from		//the air date of the first episode).		//it only gives one number after the decimal point because on the shows that was the most common format		//this is not an accurate stardate calculator but none of them are anyway :-)		public function get stardate():String {			//the number of milliseconds in a day			var singleDay:uint = 1000*24*60*60;			//the dawn of time (based on the first stardate given, the fact that stardates increment by			//2.73 (1000 / 365) stardate units per calendar day and the air date of the first TNG episode, this is			//the first date and time that gives a five digit number, 10000.0)			var startTime:Date = new Date(2333, 5, 25, 12, 15);			//the base stardate			var firstStar:uint = 10000.0;			//calculate how many days there are since that date			var daysSince:Number = (_date.getTime() - startTime.getTime()) / singleDay;			//get how many stardate units have passed			var starUnits:Number = daysSince * 2.73;			//incement the first stardate by as many stardate units as we calculated above			var stardate:Number = firstStar + starUnits;			//we don't need the startTime date object anymore			startTime = null;			//if 2.73 units pass every day that must mean that 0.113 units pass every hour			var hours:Number = _date.getHours() * 0.113;			//and that 0.00188 units pass every minute			var mins:Number = _date.getMinutes() * 0.00188;			//so the final stardate will be the number of stardate units passed since the dawn of time + 			//x for the current hour and y for the current minutes			var finalStardate:Number = stardate + hours + mins;			return finalStardate.toFixed(1).toString();		}				public function set hours(val:uint):void {			_date.setHours(val);			dispatchEvent(new Event(Event.CHANGE));		}				public function set minutes(val:uint):void {			_date.setMinutes(val);			dispatchEvent(new Event(Event.CHANGE));		}				public function set seconds(val:uint):void {			_date.setSeconds(val);			dispatchEvent(new Event(Event.CHANGE));		}				public function set day(val:uint):void {			_date.setDate(val);			dispatchEvent(new Event(Event.CHANGE));		}				public function set month(val:uint):void {			_date.setMonth(val);			dispatchEvent(new Event(Event.CHANGE));		}				public function set year(val:uint):void {			_date.setFullYear(val);			dispatchEvent(new Event(Event.CHANGE));		}	}	}