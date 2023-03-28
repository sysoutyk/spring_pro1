package com.kh.mw.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mw.service.UserService;
import com.kh.mw.service.Y_CreateService;
import com.kh.mw.service.Y_GuestService;
import com.kh.mw.service.Y_LikeService;
import com.kh.mw.util.YFileUploader;
import com.kh.mw.vo.UserVo;
import com.kh.mw.vo.Y_AskVo;
import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_HomeVo;
import com.kh.mw.vo.Y_LikeVo;
import com.kh.mw.vo.Y_MessageVo;
import com.kh.mw.vo.Y_PhotoVo;
import com.kh.mw.vo.Y_QnaVo;
import com.kh.mw.vo.Y_StoryVo;
import com.kh.mw.vo.Y_TravelVo;

@Controller
@RequestMapping(value = "/create/*")
public class YCreateController {
	@Autowired
	Y_CreateService y_createService;
	@Autowired
	Y_LikeService y_likeService;
	@Autowired
	UserService userService;
	@Autowired
	Y_GuestService y_guestService;
	
	//청첩장 입력
	@RequestMapping(value = "/form", method = RequestMethod.GET)
	public String insertInfo(HttpSession session, Model model) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		userService.updateTemptype("Y", userVo.getUserid());
		model.addAttribute("userVo", userVo);
		System.out.println("userVo" + userVo);
		return "/create/temp_y/form";
	}
	//이미지 디스플레이
	@RequestMapping(value = "/displayImg", method = RequestMethod.GET, produces = "application/text;charset=utf-8")
	@ResponseBody
	public byte[] displayImg(String pic) {
		FileInputStream fis = null;
		if(pic != null) {
			try {
				fis = new FileInputStream(pic);
				byte[] bytes = IOUtils.toByteArray(fis);
				return bytes;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (fis != null)
						fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}// displayImg
	
	//pjnum 체크
	@RequestMapping(value="/checkpjnum", method= RequestMethod.GET)
	@ResponseBody
	public int checkpjnum(String userid) {
		return userService.checkpjnum(userid);
	}
	//청첩장 입력저장
	@RequestMapping(value = "/insertInfo", method = RequestMethod.POST)
	public String insertRun(
			@RequestParam("multiFile") List<MultipartFile> multiFileList, 
			@RequestParam("arr_ques") List<String> ques, @RequestParam("arr_answers") List<String> answers,
			@RequestParam("qnos") List<Integer> qno,
			Y_HomeVo homeVo, Y_StoryVo storyVo, Y_QnaVo qnaVo, Y_TravelVo travelVo, Y_PhotoVo photoVo, 
			RedirectAttributes rttr, Model model, HttpServletRequest request, HttpSession session) {
		
			UserVo userVo = (UserVo)session.getAttribute("loginInfo");
			String userid = userVo.getUserid();
			homeVo.setUserid(userid); storyVo.setUserid(userid); qnaVo.setUserid(userid); 
			travelVo.setUserid(userid); photoVo.setUserid(userid);
			
		//pjnum 불러오기
		int prevPjnum = Integer.parseInt(request.getParameter("pjnum"));
		
	
		//이미지 입력
		for (int i = 0; i < multiFileList.size(); i++) {
			try {
				String str_coverPic = multiFileList.get(0).getOriginalFilename();
				if (str_coverPic != null && !str_coverPic.equals("")) {
					String coverPic = uploadFile(multiFileList.get(0));
					homeVo.setCoverPic(coverPic);
				}
				String str_pic_one = multiFileList.get(1).getOriginalFilename();
				if (str_pic_one != null && !str_pic_one.equals("")) {
					String story_one_pic = uploadFile(multiFileList.get(1));
					storyVo.setStory_one_pic(story_one_pic);
				}
				String str_pic_two = multiFileList.get(2).getOriginalFilename();
				if (str_pic_two != null && !str_pic_two.equals("")) {
					String story_two_pic = uploadFile(multiFileList.get(2));
					storyVo.setStory_two_pic(story_two_pic);
				}
				String str_mespic = multiFileList.get(3).getOriginalFilename();
				if (str_mespic != null && !str_mespic.equals("")) {
					String mespic = uploadFile(multiFileList.get(3));
					photoVo.setMespic(mespic);
				}
				String str_mapPic = multiFileList.get(4).getOriginalFilename();
				if (str_mapPic != null && !str_mapPic.equals("")) {
					String mapPic = uploadFile(multiFileList.get(4));
					travelVo.setMapPic(mapPic);
				}
				String str_footerpic = multiFileList.get(5).getOriginalFilename();
				if (str_footerpic != null && !str_footerpic.equals("")) {
					String footerpic = uploadFile(multiFileList.get(5));
					photoVo.setFooterpic(footerpic);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} // for

		//Q+A 첫입력	
		boolean qna_result = false;
		System.out.println("ques: " + ques);
		System.out.println("answers: " + answers);
		System.out.println("qno: " + qno);
		int nextQno;
		List<Y_QnaVo> insert_list = new ArrayList<>();
		if(prevPjnum == 0) {
			System.out.println("Q+A 첫입력");
			System.out.println("ques.size(): " + ques.size());
			
			if(ques.size() == 0) {
				nextQno = y_createService.getNextval_QnA();
				System.out.println("ques.size is 0");
				qnaVo.setQues(null);
				qnaVo.setAnswer(null);
				qnaVo.setQno(nextQno);
				qna_result = y_createService.insertQnA(qnaVo);
				System.out.println("controller insert Q+A: " + qna_result);
			}else {
				for(int i=0; i<ques.size(); i++) {
					nextQno = y_createService.getNextval_QnA();
					System.out.println("nextQno: " + nextQno);
					qnaVo.setQno(nextQno);
					qnaVo.setQues(ques.get(i));
					qnaVo.setAnswer(answers.get(i));
					insert_list.add(qnaVo);
					qna_result = y_createService.insertQnA(qnaVo);
					System.out.println("controller insert Q+A: " + qna_result);
				}
			}
		}
		//Q+A수정
		else if(prevPjnum == 1) {
			List<Y_QnaVo> update_list = new ArrayList<>();
			for(int i=0; i<ques.size(); i++) {
				if(qno.get(i) != null) {
					int existingQno = y_createService.isExistQno(userid, qno.get(i));
					System.out.println("existingQno: " + existingQno);
					if(existingQno == qno.get(i)) {
						qnaVo.setQno(qno.get(i));
						qnaVo.setQues(ques.get(i));
						qnaVo.setAnswer(answers.get(i));
						update_list.add(qnaVo);
						qna_result = y_createService.updateQna(qnaVo);
						
						
					}
				}else {
					//수정중, Q+A 추가
					nextQno = y_createService.getNextval_QnA();
					qnaVo.setQno(nextQno);
					qnaVo.setQues(ques.get(i));
					qnaVo.setAnswer(answers.get(i));
					insert_list.add(qnaVo);
					qna_result = y_createService.insertQnA(qnaVo);
				
				}
		}//for
	}
			
		boolean all_result = y_createService.insert(homeVo, storyVo, travelVo, photoVo, prevPjnum);
			if(qna_result == true && all_result == true) {
				rttr.addFlashAttribute("insert_result", "save_success");
				if(prevPjnum == 0) {
					int pjnum = userService.updatepjnum(prevPjnum, userid);
					userVo.setPjnum(pjnum);
				}
			}else {
				rttr.addFlashAttribute("insert_result", "save_fail");
			}
		session.setAttribute("url", userVo.getUrl());
		return "redirect:/create/invite";
	}
	//업로드파일
	public String uploadFile(MultipartFile file) throws Exception {
		String origionalName = file.getOriginalFilename();
		System.out.println("filename: " + origionalName);
		String filename = YFileUploader.uploadFile(origionalName, file.getBytes());
		System.out.println("filename: " + filename);
		return filename;
	}

	//청첩장 불러오기
	@RequestMapping(value="/invite", method=RequestMethod.GET)
	public String invite(HttpSession session,  Model model, String url) {
		String userid = "";
		if(url == null || url.equals("")) {
			url = (String) session.getAttribute("url");
			userid = userService.findid(url);
		}else {
			userid = userService.findid(url);
			System.out.println("invite id: " + userid);
		}
		Y_GuestPagingDto pagingDto = new Y_GuestPagingDto();
		Map<String, Object> map = y_createService.searchInfo(userid, pagingDto);
		model.addAttribute("map", map);
		model.addAttribute("url", url);

		return "/create/temp_y/home";
	}
	//청첩장 수정폼
	@RequestMapping(value = "/updateform", method = RequestMethod.GET)
	public String updateform(Model model,HttpSession session, Y_GuestPagingDto pagingDto ) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		String userid = userVo.getUserid();
		Map<String, Object> map = y_createService.searchInfo(userid, pagingDto);
		model.addAttribute("userVo", userVo);
		model.addAttribute("map", map);
		return "/create/temp_y/form";
	}

	//청첩장 질문+답변 삭제
	@RequestMapping(value="/delqna", method= RequestMethod.GET)
	@ResponseBody

	public boolean delQna (int qno, String userid) {	
		System.out.println("delqna qno: " + qno);
		System.out.println("delqna userid: " + userid);
		System.out.println("delqna");
		Y_LikeVo likeVo = new Y_LikeVo(qno, userid);
		int likecount = y_likeService.isLike(likeVo);
		System.out.println("controller delQna: " + likecount);
		if(likecount > 0) {
			boolean likedel = y_likeService.delLike(likeVo);
			if(likedel == true) {
				y_createService.delQna(qno, userid);
			}else if(likedel == false){
				y_createService.delQna(qno, userid);
			}
		}else if(likecount == 0) {
			y_createService.delQna(qno, userid);
		}		
		return true;
	}
	//our story(@청첩장)
	@RequestMapping(value = "/story", method = RequestMethod.GET)
	public String getStory(Model model, HttpSession session, String url) {
		String userid = userService.findid(url);
		Y_StoryVo storyVo = y_createService.searchStory(userid);
		Y_PhotoVo photoVo = y_createService.searchPhoto(userid);
		Y_HomeVo homeVo = y_createService.searchHome(userid);
		Map<String, Object> map = new HashMap<>();
		map.put("homeVo", homeVo);
		map.put("storyVo", storyVo);
		map.put("photoVo", photoVo);
		model.addAttribute("map", map);
		model.addAttribute("url", url);
		return "/create/temp_y/story";
	}
	//Q+A (@청첩장)
	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String getQna(Model model, HttpSession session, String url, Y_GuestPagingDto pagingDto) {
		String userid = userService.findid(url);
		System.out.println("qna controller: " + userid);
		System.out.println(pagingDto);
		List<Y_QnaVo> qnalist = y_createService.searchQna(userid, pagingDto);
		Y_PhotoVo photoVo = y_createService.searchPhoto(userid);
		Y_HomeVo homeVo = y_createService.searchHome(userid);
		Map<String, Object> map = new HashMap<>();
		map.put("qnalist", qnalist);
		map.put("photoVo", photoVo);
		map.put("homeVo", homeVo);
		model.addAttribute("map", map);
		model.addAttribute("url", url);
		model.addAttribute("userid", userid);
		model.addAttribute("pagingDto", pagingDto);
		return "/create/temp_y/qna";
	}
	//사랑의 대나무숲(@청첩장)
	@RequestMapping(value = "/showmes", method = RequestMethod.GET)
	public String getMes(Model model, HttpSession session, String url) {
		String userid = userService.findid(url);
		System.out.println("qna controller: " + userid);
		List<Y_MessageVo> meslist = y_createService.searchMes(userid);
		Y_PhotoVo photoVo = y_createService.searchPhoto(userid);
		Y_HomeVo homeVo = y_createService.searchHome(userid);
		Map<String, Object> map = new HashMap<>();
		map.put("homeVo", homeVo);
		map.put("photoVo", photoVo);
		map.put("meslist", meslist);
		model.addAttribute("map", map);
		model.addAttribute("url", url);
		return "/create/temp_y/show_message";
	}
	//하객질문 페이지(@청첩장)
	@Transactional
	@RequestMapping(value = "/guestqna", method= RequestMethod.GET)
	public String mypage(HttpSession session, Model model, String url, Y_GuestPagingDto pagingDto) {
		String userid = userService.findid(url);
		int count = y_guestService.getreadcount(userid);
		pagingDto.setPagingInfo(pagingDto.getPage(), count, pagingDto.getPerPage());
//		System.out.println(pagingDto);
		List<Y_AskVo> askVo = y_guestService.qnalist(userid, pagingDto);

		System.out.println("quesqna pagingDto: " + pagingDto);
		Y_PhotoVo photoVo = y_createService.searchPhoto(userid);
		Y_HomeVo homeVo = y_createService.searchHome(userid);
		Map<String, Object> map = new HashMap<>();
		map.put("homeVo", homeVo);
		map.put("photoVo", photoVo);
		map.put("askVo", askVo);
		model.addAttribute("map", map);
		model.addAttribute("recipient", userid);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("url", url);
		model.addAttribute("userid", userid);
		return "/create/temp_y/guestqna";
	}
	//오시는길 (@청첩장)
	@RequestMapping(value = "/travel", method = RequestMethod.GET)
	public String getTravel(Model model, HttpSession session, String url) {
		String userid = userService.findid(url);
		Y_TravelVo travelVo = y_createService.searchTravel(userid);
		Y_PhotoVo photoVo = y_createService.searchPhoto(userid);
		Y_HomeVo homeVo = y_createService.searchHome(userid);
		Map<String, Object> map = new HashMap<>();
		map.put("homeVo", homeVo);
		map.put("travelVo", travelVo);
		map.put("photoVo", photoVo);
		model.addAttribute("map", map);
		model.addAttribute("url", url);
		return "/create/temp_y/travel";
	}
	//쪽지보내기 페이지(@청첩장)
	@RequestMapping(value = "/insertmes", method = RequestMethod.GET)
	public String insertMes(Model model, HttpSession session, String url) {

		if(url == null || url == "") {
			url = (String) session.getAttribute("url");
			System.out.println("insermes" + url);
		}
		System.out.println("insertmes url: " + url);
		String userid = userService.findid(url);
		Y_PhotoVo photoVo = y_createService.searchPhoto(userid);
		Y_HomeVo homeVo = y_createService.searchHome(userid);
		Map<String, Object> map = new HashMap<>();
		map.put("homeVo", homeVo);
		map.put("photoVo", photoVo);
		model.addAttribute("map", map);
		model.addAttribute("url", url);
		model.addAttribute("userid", userid);
		return "/create/temp_y/insert_message";
	}
	//축하+감사 쪽지 db입력
	@RequestMapping(value = "/message", method = RequestMethod.POST)
	public String insertMes(MultipartFile file, Y_MessageVo mesVo, HttpSession session, Model model, 
							RedirectAttributes rttr, String url) {
		System.out.println("message url: " + url);
		String userid = userService.findid(url);
		mesVo.setRecipient(userid);
		boolean result = false;
		try {
			String filename = uploadFile(file);
			mesVo.setMespic(filename);
			result = y_createService.insertMes(mesVo);
			model.addAttribute("url", url);
			if(result == true) {
			rttr.addFlashAttribute("result", "insert_success");
			}else {
			rttr.addFlashAttribute("result", "insert_fail");
			}
			session.setAttribute("url", url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/create/insertmes";
	}
	
	
	public void update_tempinfo(int prevPjnum, String userid, String temptype) {
		userService.updatepjnum(prevPjnum, userid);
		System.out.println("controller: " + temptype);
		userService.updateTemptype(temptype, userid);
	}
	//청첩장 삭제
	@RequestMapping(value = "/create/delete", method = RequestMethod.GET)
	public String delete(HttpSession session, RedirectAttributes rttr) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		String userid = userVo.getUserid();
		//pjnum 1 -> 0, temptype 'y' -> null
		
		//하객 쪽지 삭제
		boolean isMes = y_createService.mescount(userid);
		if(isMes == true) {
			y_createService.delMes(userid);
		}
		//하객 질문 삭제
		boolean isQues = y_guestService.quescount(userid);
		if(isQues == true) {
			y_guestService.delQues(userid);
		}
		//하객 메세지 하트여부 체크
		int likecount = y_likeService.likecheck(userid);
		boolean result = false;
		String page = null;
		if(likecount > 0) {
			//하트 삭제
			boolean result_delLike = y_likeService.delete(userid);
			if(result_delLike == true) {
				result = y_createService.delete(userid);
				if(result == true) {
					userVo.setTemptype("(null)");
					update_tempinfo(userVo.getPjnum(),userVo.getUserid(),userVo.getTemptype());
					page = "redirect:/main/home_form";
					return page;
				}
			}
		}else {
			result = y_createService.delete(userid);
			if(result == true) {
				userVo.setTemptype("(null)");
				userVo.setPjnum(0);
				update_tempinfo(userVo.getPjnum(),userVo.getUserid(),userVo.getTemptype());
				page = "redirect:/main/home_form";
				return page;
			}
			rttr.addFlashAttribute("message", "fail_delete");
			page = "/create/temp_y/updateform";
		}
		return page;
	}
}