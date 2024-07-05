import unittest, json
import ../src/fix_to_json


suite "Common messages":
  test "heartbeat":
    const heartbeat="8=FIX.4.4" & chr(1) & "9=65" & chr(1) & "35=0" & chr(1) & "49=CLIENTID" & chr(1) & "56=SERVERID" & chr(1) & "34=7" & chr(1) & "52=20230715-12:36:00" & chr(1) & "10=234" & chr(1)
    let expected = %*{
      "BeginString": "FIX.4.4",
      "BodyLength": "65",
      "MsgType": "Heartbeat",
      "SenderCompID": "CLIENTID",
      "TargetCompID": "SERVERID",
      "OrderQty": "7",
      "SendingTime": "20230715-12:36:00",
      "CheckSum": "234"
    }
    check(fix_to_json(heartbeat, false) == expected)

  test "logon":
    const logon="8=FIX.4.49=10035=A49=CLIENTID56=SERVERID34=152=20230715-12:30:4598=0108=30141=Y553=USERNAME554=PASSWORD10=150"
    let expected = %*{
      "BeginString": "FIX.4.4",
      "BodyLength": "100",
      "MsgType": "Logon",
      "SenderCompID": "CLIENTID",
      "TargetCompID": "SERVERID",
      "OrderQty": "1",
      "SendingTime": "20230715-12:30:45",
      "ExDestination": "0",
      "HeartBtInt": "30",
      "SenderLocationID": "Y",
      "Unknown Field": "PASSWORD",
      "CheckSum": "150"
    }
    check(fix_to_json(logon, false) == expected)

  test "newOrder":
    const newOrder="8=FIX.4.49=21835=D49=CLIENTID56=SERVERID34=252=20230715-12:31:0011=ORD12345621=155=IBM54=160=20230715-12:31:0040=244=45.6738=10059=0100=NYSE10=062"
    let expected = %*{
      "BeginString": "FIX.4.4",
      "BodyLength": "218",
      "MsgType": "Order - Single",
      "SenderCompID": "CLIENTID",
      "TargetCompID": "SERVERID",
      "OrderQty": "100",
      "SendingTime": "20230715-12:31:00",
      "ClOrdID": "ORD123456",
      "InstrumentID": "1",
      "Symbol": "IBM",
      "Side": "1",
      "TransactTime": "20230715-12:31:00",
      "OrdType": "2",
      "Price": "45.67",
      "TimeInForce": "0",
      "OrdRejReason": "NYSE",
      "CheckSum": "062"
    }
    check(fix_to_json(newOrder, false) == expected)

  test "orderCancelRequest":
    const orderCancelRequest="8=FIX.4.49=15535=F49=CLIENTID56=SERVERID34=352=20230715-12:32:0041=ORD12345611=CXLORD12345655=IBM54=160=20230715-12:32:0038=10010=232"
    let expected = %*{
      "BeginString": "FIX.4.4",
      "BodyLength": "155",
      "MsgType": "Order Cancel Request",
      "SenderCompID": "CLIENTID",
      "TargetCompID": "SERVERID",
      "OrderQty": "100",
      "SendingTime": "20230715-12:32:00",
      "OrigClOrdID": "ORD123456",
      "ClOrdID": "CXLORD123456",
      "Symbol": "IBM",
      "Side": "1",
      "TransactTime": "20230715-12:32:00",
      "CheckSum": "232"
    }
    check(fix_to_json(orderCancelRequest, false) == expected)

  test "executionReport":
    const executionReport="8=FIX.4.49=26635=849=SERVERID56=CLIENTID34=452=20230715-12:33:0037=EXEC12345617=EXEC123456150=039=055=IBM54=138=10040=244=45.6732=031=0151=10014=06=060=20230715-12:33:0010=005"
    let expected = %*{
      "BeginString": "FIX.4.4",
      "BodyLength": "266",
      "MsgType": "Execution Report",
      "SenderCompID": "SERVERID",
      "TargetCompID": "CLIENTID",
      "OrderQty": "100",
      "SendingTime": "20230715-12:33:00",
      "OrderID": "EXEC123456",
      "ExecID": "EXEC123456",
      "LeavesQty": "0",
      "OrdStatus": "0",
      "Symbol": "IBM",
      "Side": "1",
      "OrdType": "2",
      "Price": "45.67",
      "LinesOfText": "0",
      "LastQty": "0",
      "CashOrderQty": "100",
      "CumQty": "0",
      "AvgPx": "0",
      "TransactTime": "20230715-12:33:00",
      "CheckSum": "005"
    }
    check(fix_to_json(executionReport, false) == expected)

  test "marketData":
    const marketData="8=FIX.4.49=11635=R49=CLIENTID56=SERVERID34=652=20230715-12:35:00131=QUOTEREQ123456146=155=IBM38=100010=100"
    let expected = %*{
      "BeginString": "FIX.4.4",
      "BodyLength": "116",
      "MsgType": "Quote Request",
      "SenderCompID": "CLIENTID",
      "TargetCompID": "SERVERID",
      "OrderQty": "1000",
      "SendingTime": "20230715-12:35:00",
      "BidPx": "QUOTEREQ123456",
      "Subject": "1",
      "Symbol": "IBM",
      "CheckSum": "100"
    }
    check(fix_to_json(marketData, false) == expected)
