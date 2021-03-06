/**
 * member.js
 */
var contextPath="/herb";

$(function(){
   $('#email2').change(function(){
      if($(this).val()=='etc'){
         $('#email3').val('');
         $('#email3').css('visibility', 'visible');
         $('#email3').focus();
      }else{
         $('#email3').css('visibility', 'hidden');
         
      }
   });
   
   $('#btnChkId').click(function(){
      var type=$(this).attr('class'); //admin, user
      
      open(contextPath+"/member/checkId.do?userid="+$('#userid').val()
      +"&type="+type, "chk",
      "width=400, height=300, left=0, top=0, location=yes, resizable=yes");
   });
   
   $('#btnZipcode').click(function(){
      open(contextPath+"/zipcode/zipcode.do", "chk",
      "width=500, height=550, left=0, top=0, location=yes, resizable=yes");
   });
});

   function validate_userid(id){
      var pattern=new RegExp(/^[a-zA-Z0-9_]+$/g);
      return pattern.test(id);
      /* a~z, A~Z의 문자 / 0~9의 숫자나 _로 시작하거나 끝나야 한다는 의미   |
      |  닫기 대괄호(])뒤의 +기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미  */
   }
   
   function validate_phone(tel){
      var pattern=new RegExp(/^[0-9]*$/g);
      return pattern.test(tel);
   }
   /* 0~9의 숫자로 시작하거나 끝나야 한다는 의미 (^는 시작, $는 끝을 의미)   |
   |  닫기 대괄호(]) 뒤의 *기호는 0번 이상 반복                   */
   
   function validate_email(asValue) {
	   var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	   return regExp.test(asValue); 
   }