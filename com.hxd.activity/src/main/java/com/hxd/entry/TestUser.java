package com.hxd.entry;

import javax.persistence.*;


@Entity
@Table(name = "user")
public class TestUser extends BaseEntity {

	    /**
	 * serialVersionUID
	 */
	
	private static final long serialVersionUID = 5782054115558157348L;
		@Id
	    @GeneratedValue
	    @Column(name = "id")
	    private Long id;
	    @Column(name = "userName")
	 	private String name;
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
}
