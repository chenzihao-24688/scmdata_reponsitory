CREATE OR REPLACE PROCEDURE SCMDATA.demo_queue_callback_procedure(
                     context  RAW,
                     reginfo  SYS.AQ$_REG_INFO,
                     descr    SYS.AQ$_DESCRIPTOR,
                     payload  RAW,
                     payloadl NUMBER
                     ) AS

      r_dequeue_options    SYS.DBMS_AQ.DEQUEUE_OPTIONS_T;
      r_message_properties DBMS_AQ.MESSAGE_PROPERTIES_T;
      v_message_handle     RAW(16);
      o_payload            demo_queue_payload_type;

   BEGIN

      r_dequeue_options.msgid := descr.msg_id;
      r_dequeue_options.consumer_name := descr.consumer_name;

      DBMS_AQ.DEQUEUE(
         queue_name         => descr.queue_name,
         dequeue_options    => r_dequeue_options,
         message_properties => r_message_properties,
         payload            => o_payload,
         msgid              => v_message_handle
         );

      INSERT INTO demo_queue_message_table ( message )
      VALUES ( 'Message [' || o_payload.message || '] ' ||
               'dequeued at [' || TO_CHAR( SYSTIMESTAMP,
                                          'DD-MON-YYYY HH24:MI:SS.FF3' ) || ']' );
      COMMIT;

   END;
/

